# ------------------------------------------------------------------------------
# * Modules
# ------------------------------------------------------------------------------
Import-Module -Name "PSAYX"

# ------------------------------------------------------------------------------
# * Parameters
# ------------------------------------------------------------------------------
$Name               = "Interface List Macro"    # Name of the package
$Author             = "Florian CARRIER"         # Author
$Version            = "1.0.0"                   # Version number
$CategoryName       = "Interface"               # Tool category
$Description        = "This macro enables users to use a list of values to populate an interface tool easily. It automatically transposes the values from rows to columns to match the expected format of the interface tools, and provides options to deduplicate and order values."
$Icon               = ".\Resources\icon.png"    # Package icon
$CompressionLevel   = "Optimal"                 # YXI compression level

# ------------------------------------------------------------------------------
# * Prepare package content
# ------------------------------------------------------------------------------
# Create temporary package folder
$Package = ".\YXI"
New-Item -Path $Package -ItemType "Directory" -Force | Out-Null
# Clean-up sample outputs
try {Remove-Item -Path ".\Samples\en\Macros\Output" -Recurse -Force -ErrorAction "Stop"} catch {}
# Select files to include in the package
Copy-Item -Path ".\$Name" -Destination $Package -Exclude "*.bak" -Recurse -Force
Copy-Item -Path $Icon -Destination "$Package\icon.png" -Force
Copy-Item -Path ".\Samples" -Destination $Package -Exclude "*.bak" -Recurse -Force
# Add localized samples
foreach ($Language in @("de", "es", "fr", "it", "ja", "pt", "xx", "zh")) {
    Copy-Item -Path ".\Samples\en" -Destination "$Package\Samples\$Language" -Recurse -Force
}
# Resolve package path
$Path = Resolve-Path -Path $Package

# ------------------------------------------------------------------------------
# * Build YXI
# ------------------------------------------------------------------------------
New-AlteryxPackage -Path $Path -Name $Name -Author $Author -Version $Version -CategoryName $CategoryName -Description $Description -Icon "icon.png" -CompressionLevel $CompressionLevel -Unattended

# ------------------------------------------------------------------------------
# * Clean-up
# ------------------------------------------------------------------------------
Remove-Item -Path $Path -Recurse -Force