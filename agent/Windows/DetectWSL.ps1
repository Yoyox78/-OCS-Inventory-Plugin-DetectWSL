# On récupère les utilisateurs du domaine connecté sur le compte
$Result =  (Get-WmiObject Win32_LoggedOnUser).Antecedent | select-string -pattern 'Domain="VOTREDOMAINE",Name="(.*)"$'
# On récupère que les utilisateurs
$User = ($Result.matches.groups | where-object {$_.name -eq 1}).value | Get-Unique
# On met en variable toutes les distribution existante pour WSL
$Linux = "Debian","Centos","Ubuntu","opensuse","suse","kali","fedora","pengwin","alpine","raft"

#On nettoie les variables
clear-variable -Name "Final" -ErrorAction SilentlyContinue
clear-variable -Name "distuser" -ErrorAction SilentlyContinue

# Declaration de la variable final
$xml = ""

# Création de la boucle sur l'utilisateur détécté
foreach($i in $User)
{
  # La variable path est l'endroit ou se situe les container wsl
  $path = "C:\Users\${i}\AppData\Local\Packages"
  # On verifie les dossier contenant le fichier disque contenue par wsl
  $pathvhdx = (Get-ChildItem -Path $path -Filter ext4.vhdx -Recurse -ErrorAction SilentlyContinue -Force).FullName
  # On récupère le nom de la distribution
  $distribPath = $pathvhdx | select-string -pattern '\\([^\\]*)\\LocalState\\ext4.vhdx$'
  # On met en variable uniquement le nom de la distribution (Ubuntu_79rhkp1fndgsc)
  $distrib = ($distribPath.matches.groups | where-object {$_.name -eq 1}).value
  
  # La boucle va verifier le nom de la distribution par rapport au nom du fichier trouver
  foreach($y in $Linux)
  {
    # si cela match alors on implémente le $xml
    if($distrib -match $y)
    {
      $xml += "<DETECTWSL>`n"
      $xml += "<DATE>$(Get-Date -Format "dd/MM/yyyy_HH:mm")</DATE>`n"
      $xml += "<USER>${i}</USER>`n"
      $xml += "<DISTRIB>${y}</DISTRIB>`n"
      $xml += "</DETECTWSL>`n"
    }
  }
}

$xml
