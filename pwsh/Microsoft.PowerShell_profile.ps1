# Colors-only prompt: no glyphs, no Nerd Font, no oh-my-posh dependency.
# No Terminal-Icons either: its first import costs ~700ms per new tab for icons in `ls`.

$PSStyle.FileInfo.Directory = "$($PSStyle.Bold)$($PSStyle.Foreground.Blue)"
$PSStyle.FileInfo.Executable = "$($PSStyle.Foreground.Green)"

# eza for listings: one native binary, so icons/colors/git come without a module import.
# shortcut: only ls/ll/la/lt are replaced; Get-ChildItem and gci stay for scripting
# PATH string check, not Get-Command: discovery of a missing name costs ~1.6s on this PATH
if ($env:PATH -like '*eza*') {
    Remove-Item Alias:ls -Force -ErrorAction Ignore
    $ezaOpts = '--icons=auto', '--group-directories-first'
    # this build prints nothing for a bare `eza`, so hand it '.' when no path argument is given
    function __eza { $a = @($args); if (-not ($a | Where-Object { Test-Path -LiteralPath $_ })) { $a += '.' }; eza @ezaOpts @a }
    function ls { __eza @args }
    function ll { __eza --long --git @args }
    function la { __eza --all @args }
    function lt { __eza --tree @args }
}

# shell integration: id of the last command already marked, -1 = nothing to close yet
$Global:__LastHistoryId = -1

# Windows drops non-Terminal launches (elevated, Win+R, Start menu) in System32; start home instead.
# shortcut: only redirects that dead default, so 'open Terminal here' and wt -d still work
if ($PWD.Path -eq (Join-Path $env:SystemRoot 'System32')) { Set-Location $HOME }

function prompt {
    $ok = $?  # must be first: reflects the command that just ran
    $history = Get-History -Count 1
    $path = $PWD.Path -replace ('^' + [regex]::Escape($HOME)), '~'

    # shell integration marks (OSC 133): close previous command, mark prompt, report cwd
    $out = ''
    if ($Global:__LastHistoryId -ne -1 -and $history) {
        if ($history.Id -eq $Global:__LastHistoryId) {
            $out += "`e]133;D`a"  # nothing actually ran (bare enter / ctrl+c)
        } else {
            $code = if ($ok) { 0 } elseif ($LastExitCode) { $LastExitCode } else { -1 }
            $out += "`e]133;D;$code`a"
        }
    }
    $out += "`e]133;A`a"
    $out += "`e]9;9;`"$($PWD.Path)`"`a"

    # read .git/HEAD up the tree instead of spawning git (~30-60ms per prompt)
    # shortcut: worktrees (.git is a file) and detached HEAD get no branch label
    $git = ''
    for ($d = $PWD.Path; $d) {
        $head = Join-Path $d '.git/HEAD'
        if (Test-Path $head) {
            if ((Get-Content -Raw $head) -match 'ref: refs/heads/(\S+)') {
                $git = " $($PSStyle.Foreground.Yellow)($($Matches[1]))$($PSStyle.Reset)"
            }
            break
        }
        $d = Split-Path $d -Parent
    }

    $state = if ($ok) { $PSStyle.Foreground.Green } else { $PSStyle.Foreground.Red }
    $out += "$($PSStyle.Foreground.BrightBlack)$(Get-Date -Format HH:mm:ss)$($PSStyle.Reset) " +
    "$($PSStyle.Foreground.Cyan)$path$($PSStyle.Reset)$git $state>$($PSStyle.Reset) "

    $out += "`e]133;B`a"  # prompt done, commandline starts
    if ($history) { $Global:__LastHistoryId = $history.Id }
    $out
}

# PSReadLine tokens: Terminal switches One Half Dark/Light by OS theme, so name palette colors
# (resolved per scheme) instead of One Half Light's literal RGB, which is illegible on dark
# (#383A42 text on #282C34 = 1.2:1). 39m = "scheme default foreground", because leaving a key
# unset falls back to PSReadLine's own white default (ESC[37m), which is white-on-white in light.
$fg = "`e[39m"
Set-PSReadLineOption -Colors @{
    Default            = $fg
    Member             = $fg
    ContinuationPrompt = $fg
    Command            = $PSStyle.Foreground.Blue
    Parameter          = $PSStyle.Foreground.Cyan
    Operator           = $PSStyle.Foreground.Yellow
    Variable           = $PSStyle.Foreground.Green
    String             = $PSStyle.Foreground.Green
    Number             = $PSStyle.Foreground.Yellow
    Type               = $PSStyle.Foreground.Cyan
    Comment            = $PSStyle.Foreground.BrightBlack
    Keyword            = $PSStyle.Foreground.Magenta
    Error              = $PSStyle.Foreground.Red
}
