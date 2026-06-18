---
name: book-summary
description: Summarize a book or long-form document from a source file (PDF, EPUB, etc.) into a Blinkist-style overview plus chapter-by-chapter breakdown. Use when the user wants to digest, summarize, or extract key concepts and terminology from a book.
---

# book-summary

Produce a succinct, high-signal summary of a book or long document. Combine a Blinkist-style top-level overview with a chapter-based deep dive, surfacing the key ideas and terminology a reader needs to actually use the material.

## Input

A source file: PDF, EPUB, or plain text. Read it with the available file tools.

- PDFs: use the Read tool's `pages` parameter (max 20 pages/request) to page through large files.
- EPUB: unzip and read the XHTML content files in spine order, e.g. `unzip -o book.epub -d /tmp/book` then read the `.xhtml`/`.html` files.
- If the file is large, work in sequential passes rather than trying to hold it all at once.

## Process

1. **Identify structure first.** Find the table of contents or chapter boundaries before summarizing. Note the title, author, and overall thesis.
2. **One pass per chapter.** Read each chapter, then write its summary while it's fresh. Don't summarize from the ToC alone.
3. **Extract, don't paraphrase fluff.** Prefer the author's actual claims, data, and defined terms over generic restatement.
4. **Stay succinct.** Every line should carry information a reader would highlight. Cut filler.

## Output format

```markdown
# {Title} — {Author}

## Summary

{Blinkist-style overview in 2-3 short paragraphs: open with the central thesis, then who it's for and how it's structured, then the single most important takeaway. Break paragraphs at natural shifts — don't write one dense block.}

## Key Concepts

{The book's 3-5 load-bearing ideas, each as its own subsection. Give each a paragraph of explanation, then bullets for the specifics. This is the deepest part of the top-level summary — treat each concept as something the reader should walk away genuinely understanding.}

### {Concept name}

{A paragraph explaining the idea: what it claims and why it matters.}

- {Supporting point, distinction, or implication.}
- {2-4 bullets per concept.}

## Terminology

- **{Term}** — {concise definition as the author uses it.}
{Important terms a reader needs to follow the book; omit if the book has none.}

---

## Chapter {N}: {Chapter Title}

**Key Concepts**

- **{Concept}** — {brief explanation.}
- {2-4 bullets, one idea each.}

**Critical Details**

- {Fact, datum, study, or example that supports the concepts.}
- {One bullet per detail — don't run them together.}

**Terminology**

- **{Term}** — {definition.}
{Omit the section if the chapter introduces none.}

**Connections**

- {How this chapter builds on or contrasts with an earlier chapter/concept.}
{One bullet per link; omit the section for Chapter 1.}
```

## Guidelines

- Lead with the global summary so a reader gets value in 30 seconds, then let them drill into chapters.
- Keep the top-level **Key Concepts** distinct from per-chapter ones: the top set is the book's spine, given room to breathe (a subsection each); chapter sets are local and terse (bullets only).
- Use bold for every term and named concept so the summary is skimmable.
- Favor readability: use bulleted lists (one idea per bullet) over dense single paragraphs. Never pack three or four separate points into one block of prose. Multi-sentence paragraphs belong only in the **Summary** and as the lead-in to each top-level Key Concept.
- If a chapter is thin or transitional, say so briefly rather than padding.
- Match the source's domain vocabulary — don't dumb down technical terms, define them.
