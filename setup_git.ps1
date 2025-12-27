# Git 初始設定腳本
# 這個腳本會幫你完成所有 Git 設定

Write-Host "🔧 開始設定 Git..." -ForegroundColor Green

# 檢查 Git 是否已安裝
Write-Host "`n1️⃣ 檢查 Git 安裝..." -ForegroundColor Yellow
try {
    $gitVersion = git --version
    Write-Host "✅ Git 已安裝: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Git 尚未安裝或未重新啟動終端機" -ForegroundColor Red
    Write-Host "請關閉 PowerShell 並重新開啟後再執行此腳本" -ForegroundColor Red
    exit
}

# 設定使用者資訊
Write-Host "`n2️⃣ 設定 Git 使用者資訊..." -ForegroundColor Yellow
$userName = Read-Host "請輸入你的名字"
$userEmail = Read-Host "請輸入你的 Email"

git config user.name "$userName"
git config user.email "$userEmail"
Write-Host "✅ 使用者資訊設定完成" -ForegroundColor Green

# 初始化 Git repository
Write-Host "`n3️⃣ 初始化 Git repository..." -ForegroundColor Yellow
if (Test-Path ".git") {
    Write-Host "⚠️  Git repository 已存在，跳過初始化" -ForegroundColor Yellow
} else {
    git init
    Write-Host "✅ Git repository 初始化完成" -ForegroundColor Green
}

# 連接到 GitHub
Write-Host "`n4️⃣ 連接到 GitHub..." -ForegroundColor Yellow
$remoteExists = git remote -v | Select-String "origin"
if ($remoteExists) {
    Write-Host "⚠️  已連接到 GitHub，跳過此步驟" -ForegroundColor Yellow
} else {
    git remote add origin https://github.com/cuu3v-dotcom/uni-president-website.git
    Write-Host "✅ 已連接到 GitHub" -ForegroundColor Green
}

# 拉取現有檔案
Write-Host "`n5️⃣ 同步 GitHub 檔案..." -ForegroundColor Yellow
Write-Host "⚠️  這可能會覆蓋本地檔案，請確認後繼續" -ForegroundColor Yellow
$confirm = Read-Host "是否繼續? (y/n)"
if ($confirm -eq "y" -or $confirm -eq "Y") {
    git pull origin main --allow-unrelated-histories
    Write-Host "✅ 檔案同步完成" -ForegroundColor Green
} else {
    Write-Host "⏭️  跳過檔案同步" -ForegroundColor Yellow
}

# 完成
Write-Host "`n🎉 Git 設定完成！" -ForegroundColor Green
Write-Host "`n📝 未來更新網站只需要執行:" -ForegroundColor Cyan
Write-Host "   .\deploy.ps1 `"更新說明`"" -ForegroundColor White
Write-Host "`n或手動執行:" -ForegroundColor Cyan
Write-Host "   git add ." -ForegroundColor White
Write-Host "   git commit -m `"更新說明`"" -ForegroundColor White
Write-Host "   git push origin main" -ForegroundColor White
