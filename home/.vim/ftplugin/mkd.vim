" Only do this when not done yet for this buffer
" if (exists("b:did_ftplugin"))
"   finish
" endif
" 
" let b:did_ftplugin = 1
" 
" if &textwidth == 0
"   setlocal textwidth=79
"   if !exists("b:undo_ftplugin")
"     let b:undo_ftplugin = ""
"   endif
"   let b:undo_ftplugin = b:undo_ftplugin . "|setl tw<"
" endif
