# 后腰训练台 · 训练 / 减脂 / 校园跑（个人自用）

单页网页，记录罗德里式后腰训练打卡、减脂体重、脚踝活动度、赛后复盘，以及**校园跑（2 km × 一学期 48 次）**。

## 功能

- **访问口令**：打开先输口令（默认 `houyao8`，请改掉）
- **今日速记**：大按钮一键打卡
- **四周计划**：低冲击后腰训练，点第几周就切
- **统计**：本周完成率、连续打卡天数
- **校园跑**：进度环、一键记一次、用时/备注
- **体重趋势** + **赛后复盘**
- 数据默认存**本机 localStorage**；配置好 Supabase 后自动云端同步

## 文件

| 文件 | 作用 |
|---|---|
| `index.html` | 网页本体 |
| `supabase_setup.sql` | Supabase 建表脚本（含 runs 校园跑表） |
| `README.md` | 本说明 |

## 改口令

打开 `index.html`，搜 `ACCESS_PASSWORD`，改成你自己的：

```js
const ACCESS_PASSWORD = "改成你的口令";
```

## 接上 Supabase（可选，多设备同步）

1. 在 <https://supabase.com> 用 GitHub 登录，**New project**
2. SQL Editor → 粘贴 `supabase_setup.sql` → **Run**
3. Project Settings → API，复制 **Project URL** 和 **anon public** key
4. 填进 `index.html`：

```js
const SUPABASE_URL = "https://xxxx.supabase.co";
const SUPABASE_ANON_KEY = "你的anon key";
```

5. 刷新页面，顶部出现「已连接云端」即可

> 不配 Supabase 也能用，数据存在手机/电脑本地。

## 校园跑起始次数

已经跑过、但不想补录的次数，改 `RUN_BASE`（默认 2）：

```js
const RUN_BASE = 2;
const RUN_TARGET = 48;
```

## 部署到 GitHub Pages

1. <https://github.com/new> 建仓库（Public），不要勾选初始化
2. 把 `index.html` 传到仓库根目录
3. Settings → Pages → Branch 选 `main` / `/ (root)` → Save
4. 一两分钟后打开 `https://你的用户名.github.io/仓库名/`

## 安全提示

- 口令只是挡路人，**不是**严格加密；知道网址+口令的人可查看修改
- 只适合个人训练记录，别存身份证、密码等敏感信息
- 脚踝疼痛请立即停止并就医
