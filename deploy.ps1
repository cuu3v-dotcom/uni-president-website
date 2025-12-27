# 自動部署腳本
# 使用方法: .\deploy.ps1 "更新說明"

param(
    [string]$message = "更新網站"
)

Write-Host "🚀 開始部署..." -ForegroundColor Green

# 1. 加入所有變更
Write-Host "📦 加入變更檔案..." -ForegroundColor Yellow
git add .

# 2. 建立 commit
Write-Host "💾 建立 commit: $message" -ForegroundColor Yellow
git commit -m $message

# 3. 推送到 GitHub
Write-Host "⬆️  推送到 GitHub..." -ForegroundColor Yellow
git push origin main

Write-Host "✅ 部署完成！" -ForegroundColor Green
Write-Host "🌐 Vercel 將在約 1 分鐘內自動更新網站" -ForegroundColor Cyan
Write-Host "📊 查看部署狀態: https://vercel.com/cuu3vs-projects/cuu3v-website/deployments" -ForegroundColor Cyan
