" Vim syntax file
" Language:	JavaScript
" Maintainer:	Claudio Fleiner <claudio@fleiner.com>
" Updaters:	Scott Shattuck (ss) <ss@technicalpursuit.com>
"               Spencer Tipping (st) <spencer@spencertipping.com>
" URL:		http://www.fleiner.com/vim/syntax/javascript.vim
" Changes:	(ss) added keywords, reserved words, and other identifiers
"		(ss) repaired several quoting and grouping glitches
"		(ss) fixed regex parsing issue with multiple qualifiers [gi]
"		(ss) additional factoring of keywords, globals, and members
"               (st) Added Divergence constructs, removed globals, added variable bindings, assignment highlighting, and operator highlighting
" Last Change:	2010 May 31

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
" tuning parameters:
" unlet javaScript_fold

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'javascript'
endif

" Drop fold if it set but vim doesn't support it.
if version < 600 && exists("javaScript_fold")
  unlet javaScript_fold
endif

syn case match

syn match   javaScriptAssignment        /\<\w\+\s*[^=]\([-+*\/%^&|]\|<<\|>>\|>>>\)\?=[^=]/ contains=javaScriptEquals
syn match   javaScriptEquals            /[^=]\([-+*\/%^&|]\|<<\|>>\|>>>\)\?=[^=]/

syn keyword javaScriptCommentTodo       TODO FIXME XXX TBD contained
syn match   javaScriptCommentSkip       "^[ \t]*\*\($\|[ \t]\+\)"
syn match   javaScriptSpecial	        "\\\d\d\d\|\\."
syn region  javaScriptStringD	        start=+"+  skip=+\\\\\|\\"+  end=+"\|$+  contains=javaScriptSpecial,@htmlPreproc,javaScriptDivergenceEscape
syn region  javaScriptStringS	        start=+'+  skip=+\\\\\|\\'+  end=+'\|$+  contains=javaScriptSpecial,@htmlPreproc,javaScriptDivergenceEscape

syn match   javaScriptDivergenceEscape  /#{[^}]\+}/ contains=ALL
syn match   javaScriptDivergenceEscapeD /#{\|}/

syn match   javaScriptLvalue            "++"
syn match   javaScriptLvalue            "--"

syn match   javaScriptSpecialCharacter  "'\\.'"
syn match   javaScriptNumber	        "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"

syn keyword javaScriptConditional	if else switch
syn keyword javaScriptRepeat		while for do in
syn keyword javaScriptBranch		break continue
syn keyword javaScriptOperator		new delete instanceof typeof
syn keyword javaScriptType		Array Boolean Date Function Number Object String RegExp
syn keyword javaScriptDefinition        var
syn keyword javaScriptStatement		return with
syn keyword javaScriptBoolean		true false
syn keyword javaScriptNull		null undefined
syn keyword javaScriptIdentifier	arguments this
syn keyword javaScriptLabel		case default
syn keyword javaScriptException		try catch finally throw
syn keyword javaScriptPrototype         prototype constructor

syn keyword javaScriptDivergence        comment literal
syn match   javaScriptDivergence        ">$>" contained
syn match   javaScriptDivergence        "|$>"

syn keyword javaScriptFunction          function contained
syn match   javaScriptBraces	        /[{}\[\]]/
syn match   javaScriptParens            /[()]/

syn match   javaScriptKey               /\w\+:/                contains=javaScriptOperator
syn match   javaScriptOperator          /[-+*\/%^|&!~<>:?;,$]/ contains=javaScriptDivergence
syn region  javaScriptRegexpString      start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gi]\{0,2\}\s*$+ end=+/[gi]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@htmlPreproc oneline
syn region  javaScriptComment	        start="/\*"  end="\*/" contains=@Spell,javaScriptCommentTodo
syn match   javaScriptLineComment       "\/\/.*" contains=@Spell,javaScriptCommentTodo

syn match   javaScriptBinding           /function\s*([^()]*)/ contains=javaScriptFunction,javaScriptParens
syn match   javaScriptBinding           /catch\s*([^()]\+)/   contains=javaScriptException,javaScriptParens
syn match   javaScriptBinding           /\w\+\s*>$>/          contains=javaScriptDivergence
syn match   javaScriptBinding           /([^()]*)\s*>$>/      contains=javaScriptDivergence,javaScriptParens,javaScriptOperator

syn sync fromstart
syn sync maxlines=100

if main_syntax == "javascript"
  syn sync ccomment javaScriptComment
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_javascript_syn_inits")
  if version < 508
    let did_javascript_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink javaScriptComment		Comment
  HiLink javaScriptLineComment		Comment
  HiLink javaScriptCommentTodo		Todo
  HiLink javaScriptSpecial		Special
  HiLink javaScriptStringS		String
  HiLink javaScriptStringD		String
  HiLink javaScriptCharacter		Character
  HiLink javaScriptSpecialCharacter	javaScriptSpecial
  HiLink javaScriptNumber		Number
  HiLink javaScriptConditional		Conditional
  HiLink javaScriptRepeat		Repeat
  HiLink javaScriptBranch		Conditional
  HiLink javaScriptOperator		Operator
  HiLink javaScriptType			Type
  HiLink javaScriptStatement		Statement
  HiLink javaScriptFunction		Keyword
  HiLink javaScriptError		Error
  HiLink javaScrParenError		javaScriptError
  HiLink javaScriptNull			Number
  HiLink javaScriptBoolean		Number
  HiLink javaScriptRegexpString		String

  HiLink javaScriptPrototype            Special

  HiLink javaScriptDefinition           Keyword

  HiLink javaScriptLvalue               Special
  HiLink javaScriptDivergence           Operator
  HiLink javaScriptDivergenceEscape     Normal
  HiLink javaScriptDivergenceEscapeD    Special

  HiLink javaScriptAssignment           Type
  HiLink javaScriptEquals               Operator

  HiLink javaScriptBinding              Identifier

  HiLink javaScriptKey                  Type
  HiLink javaScriptOperator             Operator
  HiLink javaScriptParens               Special
  HiLink javaScriptBraces               Special

  HiLink javaScriptIdentifier		Special
  HiLink javaScriptLabel		Label
  HiLink javaScriptException		Exception
  HiLink javaScriptMessage		Keyword
  HiLink javaScriptDebug		Debug
  HiLink javaScriptConstant		Label

  delcommand HiLink
endif

let b:current_syntax = "javascript"
if main_syntax == 'javascript'
  unlet main_syntax
endif

" vim: ts=8
