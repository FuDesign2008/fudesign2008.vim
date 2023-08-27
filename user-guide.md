# 使用手册

## [fudesign2008.vim](https://github.com/FuDesign2008/fudesign2008.vim) `.vimrc`

快捷键

| 快捷键       | 功能                             | 插件映射            | 备注 |
| :----------- | :------------------------------- | :------------------ | :--- |
| `<leader>d`  | goto definition                  | YCM/ALE/vim-lsp/coc |      |
| `<leader>td` | goto declaration                 | YCM/ALE/vim-lsp/coc |      |
| `<leader>r`  | 重命名                           | YCM/ALE/vim-lsp/coc |      |
| `<leader>rf` | 显示工程中的 refers              | YCM/coc             |      |
| `<leader>k`  | 独立窗口显示文档                 | YCM                 |      |
| `K`          | hover窗口显示文档                | YCM/ALE/vim-lsp/coc |      |
| `<leader>f`  | fix 当前行                       | ALE/coc             |      |
| `<leader>ff` | 显示`<cword>` 在文档中的所有出现 |                     |      |
| `<leader>tt` | 运行 `:NERDTreeToggle`           | NERDTree            |      |

## [FuDesign2008/only.vim](https://github.com/FuDesign2008/only.vim)

| command       | 说明                                  | 备注 |
| :------------ | :------------------------------------ | :--- |
| `:Only`       | 当前tab仅保留一个窗口，其他tab关闭    |      |
| `:Only n`     | 当前tab仅保留`n`个窗口，其他tab关闭   |      |
| `:OnlyWin`    | 当前tab仅保留一个窗口，其他tab不影响  |      |
| `:OnlyWin n`  | 当前tab仅保留`n`个窗口，其他tab不影响 |      |
| `:E`          | 编辑当前文件所在文件夹                |      |
| `:E fileName` | 编辑当前文件的相邻文件, 支持模糊补全  |      |
| `:Cfdo`       | 高性能 `:cfdo`                        |      |

特殊示例

### 1. `Cfdo`

```viml
:Ack keyword
:Cfdo %s/keyword/NewWord/g | update
```

## [FuDesign2008/ale-shim.vim](https://github.com/FuDesign2008/ale-shim.vim)

| command          | 说明                           | 备注 |
| :--------------- | :----------------------------- | :--- |
| `:ALEFixDisable` | set `g:ale_fix_on_save` to `0` |      |
| `:ALEFixEnable`  | set `g:ale_fix_on_save` to `1` |      |

## [FuDesign2008/mkdInput.vim](https://github.com/FuDesign2008/mkdInput.vim)

| command       | 说明                               | 备注 |
| :------------ | :--------------------------------- | :--- |
| `:UpdateLink` | 根据链接自动获取标题               |      |
| `:UpdateJira` | 根据链接自动获取jira标题, 需要登录 |      |

改进

1. `:UpdateLink jira`
