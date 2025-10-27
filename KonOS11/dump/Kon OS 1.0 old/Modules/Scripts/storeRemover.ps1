function Remove-AppxPackageSafe {
    param(
        [string]$PackageName
    )
    for ($i = 0; $i -lt 3; $i++) {
        try {
            $pkg = Get-AppxPackage -AllUsers $PackageName
            if ($pkg) {
                Write-Output "[$PackageName] Attempting removal (try $($i + 1))..."
                $pkg | Remove-AppxPackage -AllUsers -ErrorAction Stop
                Write-Output "[$PackageName] Successfully removed."
                break
            } else {
                Write-Output "[$PackageName] Not found for any user."
                break
            }
        } catch {
            Write-Output "[$PackageName] Removal failed (try $($i + 1)): $_"
            Start-Sleep -Seconds 2
        }
    }
}

function Remove-ProvisionedPackageSafe {
    param(
        [string]$PackageName
    )
    try {
        $prov = Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -like $PackageName }
        if ($prov) {
            Write-Output "[$PackageName] Attempting provisioned removal..."
            Remove-AppxProvisionedPackage -Online -PackageName $prov.PackageName -ErrorAction Stop
            Write-Output "[$PackageName] Provisioned package removed."
        } else {
            Write-Output "[$PackageName] Not provisioned."
        }
    } catch {
        Write-Output "[$PackageName] Provisioned removal failed: $_"
    }
}

# === Packages to Remove ===
$packages = @(
    "Microsoft.WindowsStore",
    "Microsoft.StorePurchaseApp",
    "Microsoft.XboxIdentityProvider"
)

foreach ($pkg in $packages) {
    Remove-AppxPackageSafe -PackageName $pkg
    Remove-ProvisionedPackageSafe -PackageName $pkg
}
