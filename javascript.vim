" Vim syntax file
" Language:	JavaScript with Caterwaul extensions
" Maintainer:	Spencer Tipping <spencer@spencertipping.com>
" URL:		http://www.spencertipping.com/js-vim-highlighter/javascript.vim

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'javascript'
endif

syn case match
setlocal iskeyword=48-57,95,36,A-Z,a-z

syn region    jsParenGroup              matchgroup=jsParen   start=/(/  end=/)/  contains=TOP
syn region    jsBracketGroup            matchgroup=jsBracket start=/\[/ end=/\]/ contains=TOP
syn region    jsBraceGroup              matchgroup=jsBrace   start=/{/  end=/}/  contains=TOP

syn region    jsTernary                 matchgroup=jsTernaryOperator start=/?/ end=/:/ contains=TOP,jsColonLHS
syn match     jsOperator                /[-+*^%&\|!~;=><,.]\{1,4\}/

syn keyword   jsReservedToplevel        if else switch while for do break continue return with case default try catch finally throw delete void
syn keyword   jsOperator                in instanceof typeof new
syn keyword   jsBuiltinType             Array Boolean Date Function Number Object String RegExp
syn keyword   jsBuiltinLiteral          true false null undefined

syn keyword   jsBuiltinValue            this arguments
syn keyword   jsPrototype               prototype constructor

syn match     jsAssignment              /\k\+\s*[-+*/^&|%<>]*=[^=]\@=/ contains=jsOperator

syn match     jsWordPrefix              /[-\/|,]\k\@=/

syn match     jsIdentifier              /[A-Za-z$_][A-Za-z0-9$_]*/
syn match     jsNumber                  /-\?0x[0-9A-Fa-f]\+\|-\?\(\d*\.\d\+\|\d\+\.\d*\|\d\+\)\([eE][+-]\?\d\{1,3\}\)\?\|-\?0[0-7]\+/
syn region    jsStringD                 matchgroup=jsQuote start=/"/ skip=/\\\\\|\\"/ end=/"/ oneline contains=jsStringEscape,jsCaterwaulEscape
syn region    jsStringS                 matchgroup=jsQuote start=/'/ skip=/\\\\\|\\'/ end=/'/ oneline contains=jsStringEscape,jsCaterwaulEscape
syn region    jsRegexp                  matchgroup=jsQuote start=+[-=([{!+*%&|^<>=]\@<=\s*/[^/ ]+ms=e-1,rs=e-1 start=+^\s*/[^\/]+rs=e-1 skip=+\\\\\|\\/+ end=+/[gims]*+ oneline contains=jsStringEscape

  syn match   jsStringEscape            /\\\d\{3\}\|\\u[0-9A-Za-z]\{4\}\|\\[a-z"'\\]/ contained
  syn match   jsCaterwaulEscape         /#{[^}]\+}/ contains=TOP
  syn match   jsCaterwaulNumericHex     /xl\?\(_\?[0-9a-f]\{2\}_\?\)\+/
  syn match   jsCaterwaulNumericBinary  /bl\?\(_\?[01]\{2\}_\?\)\{4,\}/

syn match     jsColonLHS                /\k\+\s*:/
syn region    jsVarBinding              matchgroup=jsVarBindingConstruct start=/var\s\|const\s/ end=/;/ contains=TOP
syn match     jsVarInBinding            /var\s\+\k\+\s\+in/ contains=jsVarBindingKeyword,jsOperator
syn region    jsParamBinding            matchgroup=jsBindingConstruct start=/\(function\|catch\)\s*(/ end=/)/ contains=jsOperator

  syn keyword jsVarBindingKeyword       const var contained
  syn keyword jsBindingKeyword          function catch contained
  syn match   jsBindingAssignment       /\k\+\s*=\([^=]\|$\)\@=/ contains=jsOperator contained containedin=jsVarBinding
  syn match   jsExtraBindingAssignment  /[A-Za-z0-9$_ ]\+\(([A-Za-z0-9$_, ]*)\)*\s*=\([^=]\|$\)/ contains=jsOperator,jsParens contained containedin=jsBindingGroup
  syn match   jsCpsBindingAssignment    /[A-Za-z0-9$_ ]\+\s*<-/                                  contains=jsOperator,jsParens contained containedin=jsCaterwaulLetCps

syn keyword   jsCaterwaul               caterwaul

syn keyword   jsBindingMacro            bind where         nextgroup=jsBindingGroup
syn keyword   jsFunctionMacro           given bgiven fn fb nextgroup=jsFunctionGroup
syn keyword   jsQuotationMacro          qs qse             nextgroup=jsQuotationGroup
syn keyword   jsOtherMacro              se effect re returning then until over over_keys over_values

syn cluster   jsMacro                   add=jsBindingMacro,jsFunctionMacro,jsQuotationMacro,jsOtherMacro

syn region    jsBindingGroup            matchgroup=jsCaterwaulMacro start='\[' end=']' contained contains=TOP
syn region    jsFunctionGroup           matchgroup=jsCaterwaulMacro start='\[' end=']' contained
syn region    jsQuotationGroup          matchgroup=jsCaterwaulMacro start='\[' end=']' contained contains=TOP

syn region    jsCaterwaulHtml           matchgroup=jsCaterwaulMacro start=/html\s*\[/ end=/]/ contains=TOP
  syn cluster jsCaterwaulHtmlOps        contains=jsCaterwaulHtmlClass,jsCaterwaulHtmlSlash,jsCaterwaulHtmlMap,jsCaterwaulHtmlAttr,jsCaterwaulHtmlParens,jsCaterwaulHtmlArray
  syn cluster jsCaterwaulHtmlOps             add=jsCaterwaulHtmlElement,jsCaterwaulHtml

  syn match   jsCaterwaulHtmlClass      /[ \t\n]*\./                    contained nextgroup=jsCaterwaulHtmlClassName
  syn match   jsCaterwaulHtmlClassName  /[ \t\n]*\w\+/                  contained nextgroup=@jsCaterwaulHtmlOps
  syn match   jsCaterwaulHtmlSlash      /[ \t\n]*\/\s*\w\+/             contained nextgroup=@jsCaterwaulHtmlOps
  syn match   jsCaterwaulHtmlAttr       /[ \t\n]*\*\s*\w\+/             contained nextgroup=@jsCaterwaulHtmlOps
  syn match   jsCaterwaulHtmlMap        /[ \t\n]*%\s*[A-Za-z0-9$_\.]\+/ contained nextgroup=@jsCaterwaulHtmlOps
  syn region  jsCaterwaulHtmlParens     matchgroup=jsParens start=/(/  end=/)/ nextgroup=@jsCaterwaulHtmlOps contains=TOP contained containedin=@jsCaterwaulHtmlOps
  syn region  jsCaterwaulHtmlArray      matchgroup=jsParens start=/\[/ end=/]/ nextgroup=@jsCaterwaulHtmlOps contains=TOP contained containedin=@jsCaterwaulHtmlOps

  syn keyword jsCaterwaulHtmlElement    html head body meta script style link title div a span input button textarea option contained containedin=@jsCaterwaulHtmlOps nextgroup=@jsCaterwaulHtmlOps
  syn keyword jsCaterwaulHtmlElement    table tbody tr td th thead tfoot img h1 h2 h3 h4 h5 h6 li ol ul noscript p pre samp contained containedin=@jsCaterwaulHtmlOps nextgroup=@jsCaterwaulHtmlOps
  syn keyword jsCaterwaulHtmlElement    blockquote select form label iframe sub sup var code caption canvas audio video     contained containedin=@jsCaterwaulHtmlOps nextgroup=@jsCaterwaulHtmlOps

syn region    jsCaterwaulSeq            matchgroup=jsCaterwaulMacro start=/seq\s*\[/    end=/]/ contains=TOP
  syn region  jsCaterwaulSeqSX          matchgroup=jsCaterwaulMacro start=/s[kvp]\s*\[/ end=/]/ contains=TOP contained containedin=jsCaterwaulSeq
  syn match   jsCaterwaulSeqVariableOp  /\([-\*/%|&]!\?\|<<\|>>\|>>>\)\~\?\k*/ contained contains=jsCaterwaulSeqVariable,jsOperator containedin=jsCaterwaulSeq
    syn match jsCaterwaulSeqVariable    /\k\+/ contained containedin=jsCaterwaulSeqVariableOp

syn match     jsCaterwaulDefsubstVar    /_\k\+/ contained containedin=jsCaterwaulDefsubst

syn match     jsCaterwaulComplexOp      /\([-+*^%&\|<>]\{1,2\}\)[A-Za-z0-9$_()\[\]]\+\1\|\([<>]\{1,2\}\)[^ ]\+[<>]\{1,2\}/

syn match     jsParens                  /[()]/ contained
syn match     jsClosers                 /[\]})]/

syn region    jsBlockComment            start=+/\*+ end=+\*/+ contains=@Spell,jsCommentTags
syn region    jsLineComment             start=+//+  end=+$+   contains=@Spell,jsCommentTags

  syn keyword jsCommentTags             TODO FIXME XXX TBD contained

syn sync fromstart
syn sync maxlines=100

if main_syntax == "javascript"
  syn sync ccomment javaScriptComment
endif

hi def link jsClosers                   Error

hi def link jsCaterwaulNumericHex       Number
hi def link jsCaterwaulNumericBinary    Number

hi def link jsCaterwaulHtmlElement      Keyword
hi def link jsCaterwaulHtmlClass        Special
hi def link jsCaterwaulHtmlClassName    Type
hi def link jsCaterwaulHtmlSlash        Special
hi def link jsCaterwaulHtmlMap          Special
hi def link jsCaterwaulHtmlAttr         Special

hi def link jsCaterwaulSeqVariable      Identifier

hi def link jsCaterwaulUnaryLeftOp      Special
hi def link jsCaterwaulComplexOp        Special
hi def link jsCaterwaulOperatorFn       Special

hi def link jsCaterwaulMacro            Special
hi def link jsCaterwaulFn               Identifier

hi def link jsWordPrefix                Special

hi def link jsBindingMacro              Special
hi def link jsFunctionMacro             Special
hi def link jsOtherMacro                Special
hi def link jsQuotationMacro            Keyword

hi def link jsFunctionGroup             Identifier

hi def link jsQuotationGroup            String

hi def link jsCaterwaul                 Type

hi def link jsLineComment               Comment
hi def link jsBlockComment              Comment
hi def link jsCommentTags               Todo

hi def link jsQuote                     Special
hi def link jsNumber                    Number
hi def link jsStringS                   String
hi def link jsStringD                   String
hi def link jsRegexp                    String
hi def link jsStringEscape              Special
hi def link jsCaterwaulEscape           Special
hi def link jsColonLHS                  Type

hi def link jsAssignment                Type

hi def link jsParen                     Special
hi def link jsParens                    Special
hi def link jsBracket                   Special
hi def link jsBrace                     Special
hi def link jsParenCloseError           Error
hi def link jsBracketCloseError         Error
hi def link jsBraceCloseError           Error

hi def link jsTernaryOperator           Special

hi def link jsVarInBinding              Type

hi def link jsVarBindingKeyword         Keyword
hi def link jsVarBindingConstruct       Keyword
hi def link jsBindingConstruct          Special
hi def link jsBindingKeyword            Keyword
hi def link jsBindingAssignment         Type
hi def link jsExtraBindingAssignment    Identifier
hi def link jsParamBinding              Identifier

hi def link jsReservedToplevel          Keyword
hi def link jsOperator                  Keyword
hi def link jsBuiltinType               Type
hi def link jsBuiltinLiteral            Special
hi def link jsBuiltinValue              Special
hi def link jsPrototype                 Special

let b:current_syntax = "javascript"
if main_syntax == 'javascript'
  unlet main_syntax
endif

" vim: ts=8
