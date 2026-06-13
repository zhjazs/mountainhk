-- hkmountain 数据库 Schema
-- 在 Supabase SQL Editor 中执行此文件

-- 1. 用户档案表
CREATE TABLE IF NOT EXISTS profiles (
  id             UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  username       TEXT NOT NULL,
  avatar_gender  TEXT DEFAULT 'boy',
  created_at     TIMESTAMPTZ DEFAULT now()
);

-- 2. 打卡记录表
CREATE TABLE IF NOT EXISTS checkins (
  id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id     UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  mountain_id TEXT NOT NULL,
  checked_at  TIMESTAMPTZ DEFAULT now(),
  UNIQUE(user_id, mountain_id)
);

-- 3. 行级安全策略 (RLS)
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE checkins ENABLE ROW LEVEL SECURITY;

-- profiles: 用户只能读写自己的档案
CREATE POLICY "Users read own profile"
  ON profiles FOR SELECT
  USING (auth.uid() = id);

CREATE POLICY "Users insert own profile"
  ON profiles FOR INSERT
  WITH CHECK (auth.uid() = id);

CREATE POLICY "Users update own profile"
  ON profiles FOR UPDATE
  USING (auth.uid() = id);

-- checkins: 用户只能读写自己的打卡记录
CREATE POLICY "Users read own checkins"
  ON checkins FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users insert own checkins"
  ON checkins FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users delete own checkins"
  ON checkins FOR DELETE
  USING (auth.uid() = user_id);

-- 4. 索引
CREATE INDEX IF NOT EXISTS idx_checkins_user ON checkins(user_id);
CREATE INDEX IF NOT EXISTS idx_checkins_mountain ON checkins(user_id, mountain_id);
