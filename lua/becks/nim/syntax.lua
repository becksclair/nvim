-- plugin/nim_syntax.lua
-- Neovim-only Nim syntax highlight (Lua). No Vimscript compat, no 'cpo' games.
-- Loads on FileType nim.

local M = {}

local function hl_link(group, link)
  -- Link highlight groups using the Lua API
  vim.api.nvim_set_hl(0, group, { link = link, default = true })
end

function M.setup_buf(buf)
  -- Guard: respect b:current_syntax convention
  if vim.bo[buf].filetype ~= "nim" then return end
  if vim.b[buf].current_syntax then return end

  -- ---------- Keywords ----------
  vim.cmd([[
    syntax case match
    syntax keyword nimKeyword asm
    syntax keyword nimKeyword bind break
    syntax keyword nimKeyword cast concept const continue
    syntax keyword nimKeyword defer discard distinct do
    syntax keyword nimKeyword end
    syntax keyword nimKeyword interface
    syntax keyword nimKeyword let
    syntax keyword nimKeyword mixin
    syntax keyword nimKeyword out
    syntax keyword nimKeyword ptr
    syntax keyword nimKeyword ref return
    syntax keyword nimKeyword static
    syntax keyword nimKeyword type
    syntax keyword nimKeyword using
    syntax keyword nimKeyword var
    syntax keyword nimKeyword yield

    syntax keyword nimConditional case elif else if when
    syntax keyword nimRepeat      for while
    syntax keyword nimLabel       block
    syntax keyword nimOperator    addr and as div in is isnot mod not notin of or shl shr xor
    syntax keyword nimException   except finally raise try

    syntax keyword nimKeyword convertor func iterator macro method proc template nextgroup=nimRoutine skipwhite
    syntax match   nimRoutine "\a\%(_\|\%(\a\|\d\)\)*" contained

    syntax keyword nimInclude export from import include
  ]])

  -- ---------- Comments ----------
  vim.cmd([[
    syntax match  nimComment    "#.*$"  contains=nimTodo,@Spell
    syntax match  nimDocComment "##.*$" contains=nimTodo,@Spell
    syntax region nimComment    start="#\["  end="\]#"   contains=nimTodo,@Spell
    syntax region nimDocComment start="##\[" end="\]##"  contains=nimTodo,@Spell
    syntax keyword nimTodo FIXME NOTE NOTES TODO XXX contained
  ]])

  -- ---------- Strings & chars ----------
  vim.cmd([[
    syntax region nimString matchgroup=nimQuotes start=+"+ end=+"+ skip=+\\"+ contains=nimEscape,nimEscapeStr
    syntax region nimString matchgroup=nimTripleQuotes start=+"""+ end=+"*\zs"""+
    syntax region nimRawString matchgroup=nimQuotes start=+[rR]"+ end=+"+ skip=+\\"+

    syntax region nimCharacter matchgroup=nimQuote start="'" end="'" skip="\\'" contains=nimEscape oneline
  ]])

  -- ---------- Escapes ----------
  vim.cmd([[
    syntax match nimEscape    contained +\\[rcnlftv\\"'abe]+
    syntax match nimEscape    contained "\\\d\+"
    syntax match nimEscape    contained "\\x\x\{2}"
    syntax match nimEscapeStr contained "\\p"
    syntax match nimEscapeStr contained "\\u\x\{4}"
    syntax match nimEscapeStr contained "\\u{\x\+}"
  ]])

  -- ---------- Numbers ----------
  vim.cmd([[
    syntax case ignore

    syntax match nimIntLit   contained "'\?[iu]\d\+"
    syntax match nimFloatLit contained "'\?\%(f\d\+\|d\)"

    " Hex
    syntax match nimInt   "\<0x\x\%(_\?\x\)*\%('[iu]\d\+\)\?\>" contains=nimIntLit
    syntax match nimFloat "\<0x\x\%(_\?\x\)*\%('\%(f\d\+\|d\)\)\>" contains=nimFloatLit
    " Dec
    syntax match nimInt   "\<\d\%(_\?\d\)*\%('\?[iu]\d\+\)\?\>" contains=nimIntLit
    syntax match nimFloat "\<\d\%(_\?\d\)*\%('\?\%(f\d\+\|d\)\)\>" contains=nimFloatLit
    " Oct
    syntax match nimInt   "\<0o\o\%(_\?\o\)*\%('\?[iu]\d\+\)\?\>" contains=nimFloatLit
    syntax match nimFloat "\<0o\o\%(_\?\o\)*\%('\?\%(f\d\+\|d\)\)\>" contains=nimFloatLit
    " Bin
    syntax match nimInt   "\<0b[01]\%(_\?[01]\)*\%('\?[iu]\d\+\)\?\>" contains=nimFloatLit
    syntax match nimFloat "\<0b[01]\%(_\?[01]\)*\%('\?\%(f\d\+\|d\)\)\>" contains=nimFloatLit
    " Float (decimals / scientific)
    syntax match nimFloat "\<\d\%(_\?\d\)*\.\d\%(_\?\d\)*\%(e[-+]\?\d\%(_\?\d\)*\)\%('\?\%(f\d\+\|d\)\)\?\>" contains=nimFloatLit
    syntax match nimFloat "\<\d\%(_\?\d\)*e[-+]\?\d\%(_\?\d\)*\%('\?\%(f\d\+\|d\)\)\?\>" contains=nimFloatLit

    syntax case match
  ]])

  -- ---------- Booleans, Types, Structures ----------
  vim.cmd([[
    syntax keyword nimBoolean true false

    syntax keyword nimType int int8 int16 int32 int64
    syntax keyword nimType uint uint8 uint16 uint32 uint64
    syntax keyword nimType float float32 float64
    syntax keyword nimType bool
    syntax keyword nimType char Rune
    syntax keyword nimType string
    syntax keyword nimType array openarray seq varargs
    syntax keyword nimType set
    syntax keyword nimType nil
    syntax keyword nimStructure enum object tuple
  ]])

  -- ---------- Builtins / Iterators ----------
  vim.cmd([[
    syntax match   nimBuiltin "@"
    syntax keyword nimBuiltin abs add addAndFetch addEscapedChar addQuitProc
    syntax keyword nimBuiltin addQuoted addr alignof alloc alloc0 alloc0Impl
    syntax keyword nimBuiltin allocCStringArray allocImpl allocSharedImpl astToStr
    syntax keyword nimBuiltin atomicDec atomicInc
    syntax keyword nimBuiltin card cas chr clamp cmp cmpMem compileOption compiles
    syntax keyword nimBuiltin copyMem cpuRelax create createShared createSharedU
    syntax keyword nimBuiltin createU cstringArrayToSeq
    syntax keyword nimBuiltin contains
    syntax keyword nimBuiltin dealloc deallocCStringArray deallocHeap deallocImpl
    syntax keyword nimBuiltin deallocShared deallocSharedImpl debugEcho dec
    syntax keyword nimBuiltin declared declaredInScope deepCopy default defined del
    syntax keyword nimBuiltin delete dispose
    syntax keyword nimBuiltin echo equalMem excl
    syntax keyword nimBuiltin find finished freeShared
    syntax keyword nimBuiltin gcInvariant getAllocStats getCurrentException
    syntax keyword nimBuiltin getCurrentExceptionMsg getFrame getFrameState
    syntax keyword nimBuiltin getFreeMem getGcFrame getMaxMem getOccupiedMem
    syntax keyword nimBuiltin getStackTrace getStackTraceEntries getTotalMem
    syntax keyword nimBuiltin getTypeInfo gorge gorgeEx
    syntax keyword nimBuiltin high
    syntax keyword nimBuiltin inc incl insert instantiationInfo internalNew isNil
    syntax keyword nimBuiltin isNotForeign iterToProc
    syntax keyword nimBuiltin len locals low
    syntax keyword nimBuiltin max min move moveMem
    syntax keyword nimBuiltin new newSeq newSeqOfCap newSeqUninitialized newString
    syntax keyword nimBuiltin ord
    syntax keyword nimBuiltin pop popGcFrame pred prepareMutation procCall protect
    syntax keyword nimBuiltin pushGcFrame
    syntax keyword nimBuiltin quit
    syntax keyword nimBuiltin rawEnv rawProc realloc0Impl reallocImpl
    syntax keyword nimBuiltin reallocShared0Imple reallocSharedImple repr
    syntax keyword nimBuiltin reprDiscriminant reset resize resizeShared
    syntax keyword nimBuiltin setCurrentException setFrame setFrameState setGcFrame
    syntax keyword nimBuiltin setLen setupForeignThreadGc shallow shallowCopy sizeof
    syntax keyword nimBuiltin slurp stackTraceAvailable staticExec staticREad substr
    syntax keyword nimBuiltin succ swap
    syntax keyword nimBuiltin tearDownForeignThreadGc toBiggestFloat toBiggestInt
    syntax keyword nimBuiltin toFloat toInt toOpenArray toOpenArrayByte toU8 toU16
    syntax keyword nimBuiltin toU32 typeof
    syntax keyword nimBuiltin unsafeAddr unsafeNew
    syntax keyword nimBuiltin wasMoved writeStackTrace

    " Iterators
    syntax keyword nimIterator countdown countup
    syntax keyword nimIterator fieldPairs fields items mitems mpairs pairs

    " Assertions
    syntax keyword nimBuiltin assert doAssert doAssertRaises failedAssertImpl
    syntax keyword nimBuiltin onFailedAssert raiseAssert

    " Dollars
    syntax match   nimBuiltin "\$"

    " IO
    syntax keyword nimBuiltin close endOfFile flushFile getFileHandle getFilePos
    syntax keyword nimBuiltin getOsFileHandle open readAll readBuffer readBytes
    syntax keyword nimBuiltin readChar readChars readFile readLine readLines
    syntax keyword nimBuiltin reopen setFilePos setInheritable setStdIoUnbuffered
    syntax keyword nimBuiltin write writeBuffer writeChars writeFile writeLine
    syntax keyword nimIterator lines

    " widestrs
    syntax keyword nimBuiltin newWideCString
  ]])

  -- ---------- Links ----------
  vim.cmd([[ syntax match nimBuiltin "\$" ]]) -- ensure defined even if IO block changes order
  vim.cmd([[ syntax match nimTripleQuotes +"""+ ]]) -- ensure group exists for link

  -- Link intermediate/custom groups to default highlight groups
  hl_link("nimTripleQuotes", "String")
  hl_link("nimFloatLit",     "SpecialChar")
  hl_link("nimIntLit",       "SpecialChar")

  hl_link("nimComment",      "Comment")
  hl_link("nimDocComment",   "Comment")
  hl_link("nimString",       "String")
  hl_link("nimRawString",    "String")
  hl_link("nimQuotes",       "String")
  hl_link("nimCharacter",    "Character")
  hl_link("nimQuote",        "Character")
  hl_link("nimInt",          "Number")
  hl_link("nimBoolean",      "Boolean")
  hl_link("nimFloat",        "Float")

  hl_link("nimRoutine",      "Function")
  hl_link("nimBuiltin",      "Function")

  hl_link("nimConditional",  "Conditional")
  hl_link("nimRepeat",       "Repeat")
  hl_link("nimLabel",        "Label")
  hl_link("nimOperator",     "Operator")
  hl_link("nimKeyword",      "Keyword")
  hl_link("nimException",    "Exception")

  hl_link("nimInclude",      "Include")

  hl_link("nimType",         "Type")
  hl_link("nimStructure",    "Structure")

  hl_link("nimEscape",       "SpecialChar")
  hl_link("nimEscapeStr",    "SpecialChar")
  hl_link("nimNumericLit",   "SpecialChar")

  hl_link("nimTodo",         "Todo")

  vim.b[buf].current_syntax = "nim"
end

function M.setup()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "nim",
    group = vim.api.nvim_create_augroup("nim_syntax_lua", { clear = true }),
    callback = function(args) M.setup_buf(args.buf) end,
  })
end

-- Auto-enable when dropped in plugin/
M.setup()

return M

