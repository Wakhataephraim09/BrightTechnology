# fix-duplicate-plugins-pom.ps1
# Run from: C:\Users\wakha\Documents\NetBeansProjects\BrightTechnology

$projectRoot = "C:\Users\wakha\Documents\NetBeansProjects\BrightTechnology"
$pomPath = Join-Path $projectRoot "bright-backend\pom.xml"

if (-not (Test-Path $pomPath)) {
    Write-Error "pom.xml not found at: $pomPath"
    exit 1
}

# Backup the pom
$ts = (Get-Date).ToString("yyyyMMdd-HHmmss")
$bakPath = "$pomPath.bak.$ts"
Copy-Item -Force $pomPath $bakPath
Write-Output "Backup created: $bakPath"

# Load XML
[xml]$xml = Get-Content -Raw -Path $pomPath

# The POM uses a default namespace; register it to query easily
$nsUri = $xml.DocumentElement.NamespaceURI
$nsMgr = New-Object System.Xml.XmlNamespaceManager($xml.NameTable)
if (![string]::IsNullOrEmpty($nsUri)) {
    $nsMgr.AddNamespace("m", $nsUri)
} else {
    # no namespace
    $nsMgr.AddNamespace("m", "")
}

# Select all <plugins> elements under /project/build
$xpath = "//m:build/m:plugins"
$pluginsNodes = $xml.SelectNodes($xpath, $nsMgr)

if ($pluginsNodes -eq $null -or $pluginsNodes.Count -le 1) {
    Write-Output "No duplicate <plugins> elements found (count: $($pluginsNodes.Count)). No changes made."
    exit 0
}

Write-Output "Found $($pluginsNodes.Count) <plugins> elements under <build>. Merging..."

# Keep first <plugins>, move children from others into the first, then remove extras
$firstPlugins = $pluginsNodes.Item(0)
for ($i = 1; $i -lt $pluginsNodes.Count; $i++) {
    $node = $pluginsNodes.Item($i)
    # Move each child (usually <plugin>) into the first <plugins>
    $children = @()
    foreach ($child in $node.ChildNodes) { $children += $child } # collect to avoid live modification
    foreach ($child in $children) {
        $imported = $xml.ImportNode($child, $true)
        $firstPlugins.AppendChild($imported) | Out-Null
    }
    # Remove the duplicate <plugins> node
    $parent = $node.ParentNode
    $parent.RemoveChild($node) | Out-Null
    Write-Output "Merged and removed duplicate <plugins> node #$i"
}

# Save the fixed pom (overwrites original)
$xml.Save($pomPath)
Write-Output "Saved corrected POM to $pomPath"
Write-Output "Please open the pom in NetBeans to confirm plugin ordering if you want."
