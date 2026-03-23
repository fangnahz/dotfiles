# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# cSpell: ignore robbyrussell, agnoster, gbdel, proxyon, proxyoff, myip

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load Claude secrets
[[ -f "$HOME/.claude_env" ]] && source "$HOME/.claude_env"

if [[ -d /opt/homebrew/bin ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
fi

export GIT_PAGER=cat
export JUPYTER_PLATFORM_DIRS=1
export UV_PYTHON_INSTALL=auto

# Claude 配置函数
# Claude: 配置一知 OpenRouter API
claude_use_openrouter() {
  export ANTHROPIC_BASE_URL="$OPENROUTER_BASE_URL"
  export ANTHROPIC_AUTH_TOKEN="$OPENROUTER_API_KEY"
  export ANTHROPIC_API_KEY=""   # Required for Claude Code + OpenRouter
  echo "Claude → OpenRouter"
}
# Claude: 配置个人 MoaCode API
claude_use_moacode() {
  export ANTHROPIC_BASE_URL="$MOACODE_BASE_URL"
  export ANTHROPIC_AUTH_TOKEN="$MOACODE_API_KEY"
  export ANTHROPIC_API_KEY=""
  echo "Claude → Moacode"
}
# Claude: 清除配置
claude_unset() {
  unset ANTHROPIC_BASE_URL ANTHROPIC_AUTH_TOKEN ANTHROPIC_API_KEY
  echo "Claude provider unset"
}
# Claude: 打印当前配置
claude_status() {
  echo "BASE_URL: ${ANTHROPIC_BASE_URL:-<unset>}"
  echo "AUTH_TOKEN: ${ANTHROPIC_AUTH_TOKEN:+<set>}${ANTHROPIC_AUTH_TOKEN:-<unset>}"
}

jump() { TERM=xterm-256color ssh -tt jump; }

lab() { source ~/.venvs/lab/bin/activate; }
alias labpy="~/.venvs/lab/bin/python"
alias labip="~/.venvs/lab/bin/ipython"

gbdel() {
  echo "+ git fetch -p"
  git fetch -p

  echo "+ git branch -vv | awk '/: gone]/{print \$1}' | while read -r b; do git branch -d \"\$b\"; done"
  git branch -vv | awk '/: gone]/{print $1}' | while read -r b; do
    git branch -d "$b"
  done
}

# --------------------------------
# 代理工具
# --------------------------------

proxyon() {
  echo "+ export http_proxy=http://127.0.0.1:7890"
  echo "+ export https_proxy=http://127.0.0.1:7890"
  echo "+ export all_proxy=socks5h://127.0.0.1:7891"
  export http_proxy="http://127.0.0.1:7890"
  export https_proxy="http://127.0.0.1:7890"
  export all_proxy="socks5h://127.0.0.1:7891"
  echo "✅ Proxy ON"
}

proxyoff() {
  echo "+ unset http_proxy https_proxy all_proxy"
  unset http_proxy https_proxy all_proxy
  echo "❌ Proxy OFF"
}

proxy() {
  if [[ -n "${http_proxy:-}" || -n "${https_proxy:-}" || -n "${all_proxy:-}" ]]; then
    proxyoff
  else
    proxyon
  fi
}

myip() {
  echo "+ curl -s https://ipinfo.io"
  curl -s https://ipinfo.io
}
export PATH="$HOME/.local/bin:$PATH"

# --------------------------------
# 代理工具结束
# --------------------------------

# --------------------------------
# 周报生成工具 (Codex)
# --------------------------------

_wr_files_to_read() {
  local files=(
    REPORT_SPEC.md
    okr.md
    d1-mon.md d2-tue.md d3-wed.md d4-thu.md d5-fri.md
  )
  [[ -f VALUE_PHRASES.md ]] && files+=(VALUE_PHRASES.md)
  [[ -f LAST_WEEK_CARRYOVER.md ]] && files+=(LAST_WEEK_CARRYOVER.md)
  printf -- "- %s\n" "${files[@]}"
}

# 内部工具：检查必须的文件是否存在
_wr_require_file() {
  local f="$1"
  if [[ ! -f "$f" ]]; then
    echo "✗ Missing file: $f"
    return 1
  fi
  return 0
}

# 内部工具：检查当前是否在周报文件夹下
_wr_check() {
  local ok=1
  # _wr_require_file "REPORT_SPEC.md" || ok=0
  _wr_require_file "okr.md"         || ok=0
  for d in d1-mon.md d2-tue.md d3-wed.md d4-thu.md d5-fri.md; do
    _wr_require_file "$d" || ok=0
  done
  if [[ ! -d "members" ]]; then
    echo "✗ Missing folder: members/"
    ok=0
  fi
  if [[ "$ok" -eq 0 ]]; then
    echo "Hint: run these inside your week folder (e.g., w05/)."
    return 1
  fi
  echo "✓ Weekly folder looks OK."
  return 0
}

# 初始化辅助文档：创建上周遗留任务文件和价值短语文件
wr_init() {
  _wr_check || return 1
  if [[ ! -f "REPORT_SPEC.md" ]]; then
    cat > REPORT_SPEC.md <<'EOF'
# 周报写作规范

语言：中文为主（可少量英文术语，但不要堆砌缩写）
受众：CEO / 高层（3–5 分钟可读完）
目标：用“价值/结果”讲清楚本周做了什么、为什么重要、风险在哪、下周要交付什么

## 反空话规则（强制）

- Value > activity. Prefer outcomes, impact, risk reduced, time saved, revenue enabled.
- Concise. No big empty buzz words.
- Concrete. Use metrics/examples when available.

## 价值表达模板（优先使用）

如果可能的话，每条尽量写成：

- 【做了什么】→【带来什么价值】→【证据/指标/影响面】

示例：

- 完成 XX 模块上线 → 降低人工审核成本 → 审核时长从 A 降到 B / 覆盖 N 条场景
- 修复 XX 线上问题 → 降低故障风险 → 错误率从 A% 降到 B% / 告警减少 N
- 推进 XX 客户交付 → 加速回款/续费 → 里程碑：已交付/已验收/进入试点

## 生成周报结构（必须严格一致）

```markdown
# 周报

## 「本月」目标及计划
- 3–6 条：面向“结果/里程碑”，不要写任务清单
- 若有 OKR：按 OKR 口径归类（可在括号中标注 O/KR 编号）

## 「本周」已完成及反思沉淀

个人任务

- 【优先级】结果与价值 > 分类完整性 > 表达形式
- 按照任务类别对本周工作进行总结。常见任务类别包括：大模型外呼服务相关工作、团队管理、项目支持、协调与沟通；如有必要，可在不改变原意的前提下合理补充。
- 任务类别作为四级标题，在每个类别下归纳整理具体任务
- 每个任务类别四级标题之下，优先写“可交付 / 可验收 / 可量化”的成果
- 强调价值，如果有数据支持的话给出关键数据或证据，说明影响，具体做了什么尽量简洁明了的总结说明

## 「本周」未完成及原因分析
- 大多数情况下留空，有明确未完成事项时才需要写
- 原因分类：外部依赖 / 资源不足 / 目标不清 / 方案风险 / 时间评估偏差
- 必须包含：补救方案 + 下一步动作 + 预计完成时间

## 「下周」目标及计划
- 3–6 条
- 必须是“交付物 / 验收标准”，避免“继续优化 / 持续推进”
- 尽量包含：Deliverable + 截止时间 + 风险/依赖

```

EOF
    echo "✓ Created REPORT_SPEC.md"
  else
    echo "• REPORT_SPEC.md exists"
  fi
  if [[ ! -f "LAST_WEEK_CARRYOVER.md" ]]; then
    cat > LAST_WEEK_CARRYOVER.md <<'EOF'
# 上周遗留（≤10 行，供本周参考）
- 延期事项：
  - n/a
- 风险：
  - n/a
- 承诺：
  - n/a
EOF
    echo "✓ Created LAST_WEEK_CARRYOVER.md"
  else
    echo "• LAST_WEEK_CARRYOVER.md exists"
  fi

  if [[ ! -f "VALUE_PHRASES.md" ]]; then
    cat > VALUE_PHRASES.md <<'EOF'
# 价值表述词库
- 交付风险降低：避免延期/避免返工/降低线上事故概率
- 成本降低：减少人工审核/减少标注成本/减少算力开销
- 体验提升：提升命中率/减少误判/提升转化/提升接通率
- 效率提升：缩短迭代周期/减少排查时间/减少重复劳动
- 可运营：增加可观测性/可回溯/可配置/可解释
EOF
    echo "✓ Created VALUE_PHRASES.md"
  else
    echo "• VALUE_PHRASES.md exists"
  fi
}

# 生成周报初稿：根据每日工作的详细日志和 okr 生成周报初稿
wr_draft() {
  codex exec -C . --sandbox workspace-write <<EOF
请阅读以下文件：
$(_wr_files_to_read)

任务：
1. 按 REPORT_SPEC.md 生成 ./weekly.md（中文）
2. 严格使用规定的四个主章节结构
3. 内容要求：
   - 价值导向、可证伪、无空话
   - 面向 CEO：强调结果、影响、风险、交付
EOF
}

# 生成团队总结：根据每个成员的周报和 okr 生成团队总结
wr_members() {
  _wr_require_file REPORT_SPEC.md || return 1
  [[ -d members ]] || return 1

  codex exec -C . --sandbox workspace-write <<'EOF'
请阅读 REPORT_SPEC.md 以及 members/*/weekly.md 和 members/*/okr.md。

任务：
生成 ./team_summary.txt，仅包含「团队成员进展」内容：
- 第一行是 “团队成员进展”
- 每位成员姓名单独占一行座位列表总起/说明行，成员具体的工作内容在下面作为列表项输出
- 每人 1–3 条
- 仅保留最关键的结果、OKR 对齐、风险与下一步
- 不写过程流水账、不写空话
EOF

  echo "✓ Generated team_summary.md. 下一步：手动编辑，把团队成员进展合并进 weekly.md，审核修订。"
}

# 改写周报初稿：收紧内容，突出价值
wr_rewrite() {
  _wr_require_file weekly.md || return 1
  _wr_require_file REPORT_SPEC.md || return 1

  codex exec -C . --sandbox workspace-write <<'EOF'
请阅读 REPORT_SPEC.md 与 weekly.md。

任务：
在不改变结构和章节标题的前提下，改写并收紧 weekly.md：
- 删除空话、套话和低价值细节
- 合并重复表达
- 确保每条都能回答“为什么 CEO 需要知道这件事”
- 优先突出：结果 / 影响 / 风险 / 交付 / 组织效率
目标：在保留重要信息的前提下，争取减少一些低价值细节，注意要保证信息密度不丢失
EOF

  # 结束，删除辅助文档
  rm -f REPORT_SPEC.md VALUE_PHRASES.md LAST_WEEK_CARRYOVER.md team_summary.md
}

# --------------------------------
# 周报生成工具 (Codex) 结束
# --------------------------------
