Import-Module -Name Terminal-Icons
Import-Module posh-git
New-Alias k kubectl
Remove-Alias h
New-Alias h helm
New-Alias g goto

function goto {
    param (
        $location
    )

    Switch ($location) {
        "pr" {
            Set-Location -Path "$HOME/projects"
        }
        "bp" {
            Set-Location -Path "$HOME/projects/boilerplates"
        }
        "cs" {
            Set-Location -Path "$HOME/projects/cheat-sheets"
        }
        default {
            Write-Output "Invalid location"
        }
    }
}
# TODO: configure kube later
# $ENV:KUBECONFIG = ".kube/prod-k8s-clcreative-kubeconfig.yaml;.kube/civo-k8s_test_1-kubeconfig;.kube/k8s_test_1.yml"

# function kn {
#     param (
#         $namespace
#     )

#     if ($namespace -in "default","d") {
#         kubectl config set-context --current --namespace=default
#     } else {
#         kubectl config set-context --current --namespace=$namespace
#     }
# }
$ENV:STARSHIP_CONFIG = "$HOME\.config\starship\starship.toml"
$ENV:STARSHIP_DISTRO = "者 sairu "
Invoke-Expression (&starship init powershell)
fnm env --use-on-cd --version-file-strategy=recursive | Out-String | Invoke-Expression

if ($host.Name -eq 'ConsoleHost')
{
    Import-Module PSReadLine
}
    Import-Module PSReadLine

Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

# This is an example of a macro that you might use to execute a command.
# This will add the command to history.
Set-PSReadLineKeyHandler -Key Ctrl+Shift+b `
                         -BriefDescription BuildCurrentDirectory `
                         -LongDescription "Build the current directory" `
                         -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("ng build")
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}
