# 🏔️ 香港山脉打卡

香港山脉打卡网页 — 卡通地图 + 实时天气 + 登山成就系统。

## 技术栈

- 前端：原生 HTML/CSS/JS
- 后端：Supabase（认证 + 数据库）
- 天气：Open-Meteo API（免费）
- 部署：Vercel

## 部署步骤

### 1. Supabase 设置

1. 前往 [supabase.com](https://supabase.com) 注册并创建项目
2. 在 SQL Editor 中执行 `supabase/schema.sql`
3. 在 Settings → API 中获取 `URL` 和 `anon key`
4. （可选）在 Authentication → Settings 中关闭邮箱确认

### 2. 配置环境变量

将 Supabase 凭据填入 `index.html` 中的配置：

```js
const SUPABASE_URL = '你的 Supabase URL';
const SUPABASE_ANON_KEY = '你的 anon key';
```

### 3. Vercel 部署

1. 将项目推送到 GitHub
2. 在 [vercel.com](https://vercel.com) 导入仓库
3. 设置 Root Directory 为 `hkmountain/`
4. 部署

## 项目结构

```
hkmountain/
├── index.html        # 主应用（单文件）
├── supabase/
│   └── schema.sql    # 数据库建表 SQL
├── assets/           # 图片素材
└── README.md
```
