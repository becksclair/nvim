-- lua/indent/nim.lua
-- Nim indent rules (Lua) converted from the original Vim indent script.

local M = {}

-- Compute indent for the given line number (lnum).
-- Used via: v:lua.require'indent.nim'.get(v:lnum)
function M.get(lnum)
  lnum = tonumber(lnum) or vim.v.lnum

  -- previous non-blank line
  local plnum = vim.fn.prevnonblank(lnum - 1)
  if plnum == 0 then
    return 0
  end

  local pline = vim.fn.getline(plnum)

  -- If previous line is a comment: keep current indent (-1).
  if pline:match("^%s*#") then
    return -1
  end

  -- Base indent of previous non-blank line
  local ind = vim.fn.indent(plnum)

  -- Strip trailing comments for pattern checks
  pline = pline:gsub("#.*$", "")

  local sw = vim.fn.shiftwidth()

  -- If previous line ends with a colon -> indent
  if vim.fn.match(pline, [[\v:\s*$]]) >= 0 then
    return ind + sw
  end

  -- Terminating exec statements -> dedent
  if vim.fn.match(pline, [[\v^\s*(break|continue|discard|return)\>]]) >= 0 then
    return ind - sw
  end

  -- Assignment-like keywords on their own line -> indent
  if vim.fn.match(pline, [[\v^\s*(const|let|type|var)\s*$]]) >= 0 then
    return ind + sw
  end

  -- Advanced type decls after '=' -> indent
  if vim.fn.match(pline, [[\v=\s*(concept|enum|tuple)\s*$]]) >= 0 then
    return ind + sw
  end

  -- Object type decls (possibly "ref object") -> indent
  if vim.fn.match(pline, [[\v=\s*(ref\s*)?object\s*$]]) >= 0 then
    return ind + sw
  end

  -- Previous line ends with '=' -> indent
  if vim.fn.match(pline, [[\v=\s*$]]) >= 0 then
    return ind + sw
  end

  local line = vim.fn.getline(lnum)

  -- Current line begins with elif|else -> dedent
  if vim.fn.match(line, [[\v^\s*(elif|else)\>]]) >= 0 then
    return ind - sw
  end

  -- Fallback to cindent like the original
  return vim.fn.cindent(lnum)
end

-- Buffer-local setup for Nim indenting
function M.setup()
  if vim.b.did_indent then return end
  vim.b.did_indent = true

  local bo = vim.bo

  -- Mirror original choices
  bo.cinoptions = "(1s,m1)"  -- parentheses/brace tuning; original had "(1s,m1"
  bo.autoindent = true
  bo.lisp = false

  -- Extend indentkeys with '==' and 'elif' (idempotent-ish append)
  local ik = bo.indentkeys or ""
  if ik == "" then
    bo.indentkeys = "==,elif"
  else
    bo.indentkeys = ik .. ",==,elif"
  end

  -- Use Lua indentexpr
  bo.indentexpr = "v:lua.require'indent.nim'.get(v:lnum)"
end

return M

