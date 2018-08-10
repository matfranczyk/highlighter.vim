function highlighter#Highlight(mode)

   if a:mode == 'h'
      let match_pat = '.*\%'.line(".").'l.*'
      exec 'syn match '. s:lcolor_grp . s:lcolor_n . ' "' . match_pat . '" containedin=ALL'
   elseif a:mode == 'a'
      let s:lcolor_n = s:lcolor_n == s:lcolor_max - 1 ? 0 : s:lcolor_n + 1
   elseif a:mode == 'r'
      exec 'syn clear ' . s:lcolor_grp . s:lcolor_n
      let s:lcolor_n = s:lcolor_n == 0 ? 0 : s:lcolor_n - 1
   else
   endif

   let cur_word = a:mode == 's' || a:mode == 'j' ? @/ : expand("<cword>")


   if cur_word == ""
      " do nothing
   elseif a:mode == 'f' || a:mode == 's'
      let s:pcolor_n = s:pcolor_n == s:pcolor_max - 1 ?  1 : s:pcolor_n + 1
      exec 'syn match ' . s:pcolor_grp . s:pcolor_n . ' "' . cur_word . '" containedin=ALL'
   elseif a:mode == 'w'
      let s:pcolor_n = s:pcolor_n == s:pcolor_max - 1 ?  1 : s:pcolor_n + 1
      exec 'syn match ' . s:pcolor_grp . s:pcolor_n . ' "\<' . cur_word . '\>" containedin=ALL'
   elseif a:mode == 'k' || a:mode == 'j'
      let s:pcolor_n = s:pcolor_n == s:pcolor_max - 1 ?  1 : s:pcolor_n + 1
      exec 'syn match ' . s:pcolor_grp . s:pcolor_n . ' ".*' . cur_word . '.*" containedin=ALL'
   elseif a:mode == 'l'
      let s:pcolor_n = s:pcolor_n == s:pcolor_max - 1 ?  1 : s:pcolor_n + 1
      exec 'syn match ' . s:pcolor_grp . s:pcolor_n . ' ".*\<' . cur_word . '\>.*" containedin=ALL'
   elseif a:mode == 'd'
      exec 'syn clear ' . s:pcolor_grp . s:pcolor_n
      let s:pcolor_n = s:pcolor_n == 0 ? 0 : s:pcolor_n - 1
   else
   endif

   " Clean all
   if a:mode == 'n'
      let ccol = 0
      while ccol < s:lcolor_max
         exec 'syn clear '. s:lcolor_grp . ccol
         let ccol = ccol + 1
      endw

      let ccol = 0
      while ccol < s:pcolor_max
         exec 'syn clear '. s:pcolor_grp . ccol
         let ccol = ccol + 1
      endw

      let s:lcolor_n = 0
      let s:pcolor_n = 0
   else
   endif

endfunction


function s:FlashCurrentLine()
    let match_pat = '.*\%'.line(".").'l.*'
    exec 'syn match '. s:lcolor_grp . s:lcolor_n . ' "' . match_pat . '" containedin=ALL'
endfunction


function s:NextColor()
    let s:lcolor_n = s:lcolor_n == s:lcolor_max - 1 ? 0 : s:lcolor_n + 1
endfunction


function s:FlashWordMatchUnderCursor()
    let l:word = expand("<cword")

    let s:pcolor_n = s:pcolor_n == s:pcolor_max - 1 ?  1 : s:pcolor_n + 1
    exec 'syn match ' . s:pcolor_grp . s:pcolor_n . ' "\<' . cur_word . '\>" containedin=ALL'
endfunction


function s:FlashWordUnderCursor()
    let l:word = expand("<cword")

    let s:pcolor_n = s:pcolor_n == s:pcolor_max - 1 ?  1 : s:pcolor_n + 1
    exec 'syn match ' . s:pcolor_grp . s:pcolor_n . ' "' . cur_word . '" containedin=ALL'
endfunction
