---
title: Miniforge3 Notes
date: 2026-03-17 18:30:00 +0800
categories: [Notes, Development Tools]
tags: [python, miniforge, conda, vscode]
description: Miniforge3 on macOS 的基础使用笔记，包括安装、卸载、环境管理、项目本地 .venv、VSCode/Cursor 配置。
---

## 1. What is Miniforge3

Miniforge3 是一个轻量的 Python 环境管理方案，本质上是 **conda-forge** 生态下的 Conda 发行版。  
如果你不想继续使用体积较大、预装内容较多的 Anaconda，那么在 macOS 上使用 Miniforge3 通常会更清爽一些。

它主要用来做几件事：

- 安装 Python
- 创建独立环境
- 给不同项目隔离依赖
- 管理包（`conda` / `mamba`）

> 对于日常开发来说，Miniforge3 + 项目独立环境 已经足够。
{: .prompt-tip }

---

## 2. 常用指令总览

| Operation            | Command                                     |
| -------------------- | ------------------------------------------- |
| Check conda version  | `conda --version`                           |
| Show conda info      | `conda info`                                |
| Create named env     | `conda create -n py312 python=3.12`         |
| Activate named env   | `conda activate py312`                      |
| Create project env   | `conda create -p ./.venv python=3.12`       |
| Activate project env | `conda activate ./.venv`                    |
| List envs            | `conda env list`                            |
| Install package      | `conda install numpy`                       |
| Install with pip     | `pip install requests`                      |
| Exit env             | `conda deactivate`                          |
| Remove named env     | `conda env remove -n py312`                 |
| Remove project env   | `conda env remove -p ./.venv`               |
| Shorten prompt name  | `conda config --set env_prompt '({name}) '` |

---

## 3. 安装 Miniforge3

进入 Miniforge 的 [GitHub Release 页面](https://github.com/conda-forge/miniforge/releases)，下载适合你机器的脚本：

- Apple Silicon 通常选择 `arm64`
- Intel Mac 选择 `x86_64`

已经下载好了安装脚本后，直接运行脚本，例如：

```bash
bash Miniforge3-MacOSX-arm64.sh

# 查看安装信息
conda --version
conda info
```

## 4. Basic Conda Commands

### 4.1 Update Conda

```bash
conda update -n base conda
```

### 4.2 Search Python versions

```bash
conda search python
```

### 4.3 Create a named environment

例如创建一个 Python 3.12 环境：

```bash
# 将环境创建到 Conda 默认的环境目录里，名称为 py312
conda create -n py312 python=3.12

# 将环境创建到目标路径 ./.venv 下
conda create -p ./.venv python=3.12
```

### 4.4 Activate environment

```bash
# 如果是使用名称进行创建的环境，则使用名称激活环境
conda activate py312
# (py312) oliver@yunfandeMacBook-Pro ~ %


# 如果是使用路径撞见的环境，使用路径激活环境
conda activate ./.venv
```

### 4.5 Check installed packages

```bash
conda list
```

### 4.6 Install package

```bash
conda install numpy

# Alternatively
pip install requests
```

> 一般来说，能用 conda 装的包优先用 conda；没有的话再用 pip。
{: .prompt-info }

### 4.7 Exit environment

```bash
conda deactivate
```

### 4.8 Use Mamba for Faster Installation

Miniforge 通常也支持 `mamba`，它和 `conda` 的命令形式很像，但是依赖解析更快。

例如：

```bash
mamba create -n testenv python=3.11
mamba install pandas
```

如果没有 `mamba`，可以先安装：

```bash
conda install mamba -n base -c conda-forge
```

---

## 5. Python Environment for Local Project

### 5.1 Environment Create

很多时候不想把环境统一放在全局 `envs/` 目录下，而是希望每个项目自己带一个环境，例如放在项目里的 `.venv`。

假设你当前项目目录是：

```text
/Users/oliver/ResearchDigest-Bot
```

那么可以进入项目目录后执行：

```bash
cd /Users/oliver/ResearchDigest-Bot
conda create -p ./.venv python=3.12

# Activation
conda activate ./.venv
```

这时你就在当前项目内部拥有了独立 Python 环境。

### 5.2. Fix Long Prompt for Prefix-based Envs

当你使用 `-p ./.venv` 这种 **prefix-based environment** 时，Conda 有时会在终端提示符里显示完整绝对路径，例如：

```text
(/Users/oliver/ResearchDigest-Bot/.venv) oliver@yunfandeMacBook-Pro ResearchDigest-Bot %
```

这个太长，不美观。因此可以设置以下内容：

```bash
conda config --set env_prompt '({name}) '
```

注意，这个对当前用户级别的 Conda 配置生效。不是项目内的。

然后重新切换环境：

```bash
conda deactivate
conda activate ./.venv
```

这样提示符通常就会变成：

```text
(.venv) oliver@yunfandeMacBook-Pro ResearchDigest-Bot %
```

如果想要检查和消除这个设置，可以执行：

```bash
conda config --show env_prompt
conda config --remove-key env_prompt
```

输出示例：

```text
env_prompt: ({name}) 
```

> 如果你使用项目内 `.venv`，这个设置非常推荐保留。
{: .prompt-tip }


## 6. Config Current Python Environment for Curosr/Vscode

在 VSCode / Cursor 中：

- 打开 Command Palette
- 搜索 `Python: Select Interpreter`
- 选择项目中的 `.venv/bin/python`

在 macOS 下通常路径类似于：

```text
/Users/oliver/ResearchDigest-Bot/.venv/bin/python
```

选中后，这个项目就会使用自己的 Python 环境。接下来在终端里进行验证：

```bash
which python
python --version
```

## 7. Common Environment Operations

### 7.1 View all environments

```bash
$ conda env list

# conda environments:

base                  *  /Users/oliver/miniforge3
py312                    /Users/oliver/miniforge3/envs/py312
                         /Users/oliver/ResearchDigest-Bot/.venv
```

### 7.2 Remove a named environment

```bash
conda env remove -n py312
```

### 7.3 Remove a project-local environment

```bash
conda env remove -p ./.venv
```

或者直接删除目录也可以，但更推荐用 Conda 命令删除。

### 7.4 Export environment

```bash
conda env export > environment.yml
```

### 7.5 Recreate from file

```bash
conda env create -f environment.yml
```
---

## 8. Miniforge3 Uninstall

如果你想彻底卸载 Miniforge3，可以分三步做。

### 8.1 Remove installation directory

假设安装在：

```text
/Users/oliver/miniforge3
```

则删除：

```bash
rm -rf ~/miniforge3
```

### 8.2 Remove shell init content

打开你的 shell 配置文件，例如：

- `~/.zshrc`
- 或 `~/.bash_profile`

删除类似下面这段由 `conda init` 写入的内容：

```bash
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
...
# <<< conda initialize <<<
```

然后重新加载：

```bash
source ~/.zshrc
```

### 8.3 Remove config files if needed

如果你想清理得更彻底，可以删掉这些文件：

```bash
rm -f ~/.condarc
rm -rf ~/.conda
```

> 删除这些配置前，确认你不再需要旧环境信息。
{: .prompt-warning }
