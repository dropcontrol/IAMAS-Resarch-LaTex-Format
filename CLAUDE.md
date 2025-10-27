# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## リポジトリ概要

情報科学芸術大学院大学（IAMAS）の修士論文用LaTeXフォーマット（非公式）

**重要**: このフォーマットは非公式に作成されたものです。使用時は必ずユーザー自身で確認と責任において使用してください。

## ドキュメント構成

- **`iamas.tex`**: 基本テンプレートファイル（サンプル内容付き）
- **`iamas_yamato.tex`**: 実際の論文例（大きなサンプル）
- **`iamas.sty`**: IAMASカスタムスタイル定義（参考作品リスト、図表番号など）
- **`chicago.sty`** / **`chicago.bst`**: Chicago引用スタイル

## LaTeXコンパイル方法

### 標準（推奨）: uplatex使用

```bash
# UTF-8の欧文特殊文字に対応
uplatex <filename>.tex
uplatex <filename>.tex  # 2回実行（参照を正しく生成）
dvipdfmx <filename>.dvi
```

### 代替: platex使用

platexを使用する場合は、`.tex`ファイルで以下の変更が必要:

1. `\documentclass[uplatex,dvipdfmx]{ujarticle}` をコメントアウト
2. `\documentclass[dvipdfmx]{jsarticle}` をコメント解除
3. ウムラウト・アクセント記号をLaTeX記法（例: `\"u`）に置き換え
4. 多言語対応パッケージ（`otf`, `fontenc`, `inputenc`, `pxcjkcat`）をコメントアウト

### コンパイル実行例

```bash
# iamas.texをコンパイルする場合
uplatex iamas.tex
uplatex iamas.tex
dvipdfmx iamas.dvi
```

## 論文構造

### 必須要素

1. **表紙**: `\title{}`, `\author{}`, `\date{}`で定義
2. **修士論文要旨**: 表形式で日本語995文字以内
3. **ABSTRACT**: 表形式で英語（参考: サンプルは452ワード）
4. **目次**: `\tableofcontents`
5. **本文**: セクション構造（`\section`, `\subsection`, `\subsubsection`）

### ページレイアウト

- 余白: 上25mm, 下30mm, 左右30mm (`geometry`パッケージで設定済み)
- フォントサイズ: `\large`（本文全体）

### 改ページ制御

図版や章をページに収める場合:

```latex
\afterpage{\clearpage}
\newpage
```

## 重要なパッケージと機能

### 標準で有効なパッケージ

- `amsmath`: 数式
- `graphicx`: 画像挿入
- `url`: URL表記
- `wrapfig`: 回り込み図版
- `chicago`: Chicago引用スタイル
- `caption`: キャプション設定
- `here`: 図表位置固定 (`[H]`オプション)

### カスタムコマンド（iamas.sty）

- **参考作品リスト**: `\begin{referenceworks}...\end{referenceworks}`
- **図表番号**: 自動的に太字で「図 X」「表 X」と表示
- **フランス語引用符**: `\flqq` (<<), `\frqq` (>>)
- **傍点**: `\boutenchar`で「・」

## 論文執筆時の注意点

### 多言語特殊文字

uplatex使用時はUTF-8の特殊文字（ウムラウト、アクセント記号など）がそのまま使用可能。platex使用時はLaTeX記法に変換必要。

### エラー対応

多言語対応パッケージで「utf8がない」「\u8がない」などのエラーが出る場合がありますが、コンパイルは続行できます（ファイル内コメント参照）。

## Git管理

- 現在のブランチ: `master`
- コンパイル生成物（`.aux`, `.log`, `.toc`, `.dvi`など）は適切に`.gitignore`で除外することを推奨
- 作業中PDFは`_TBC_*.pdf`というプレフィックスを使用して主査副査と共有可能（推奨）

## 一般的な作業フロー

1. `iamas.tex`をベースに新しい`.tex`ファイルを作成
2. タイトル、著者、日付を更新
3. 修士論文要旨（日本語・英語）を記入
4. 本文セクションを執筆
5. uplatex/dvipdfmxでコンパイル
6. PDFを確認
