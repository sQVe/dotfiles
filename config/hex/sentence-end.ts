// Ending punctuation may sit inside closing quotes or brackets.
const endsWithPunctuation = /[.!?…]["'”’)\]]*$/

// Spoken lead-ins that come before the words that make a question.
const leadingFillers = new Set(["so", "and", "but", "okay", "ok", "well", "also", "like"])

// These start a question on their own.
const questionWords = new Set(["what", "why", "how", "when", "where", "who", "whom", "whose", "which"])

// These also start statements ("Do the dishes"), so they count only when a
// subject follows them.
const auxiliaryVerbs = new Set([
  "is", "are", "am", "was", "were",
  "do", "does", "did",
  "can", "could", "should", "would", "will", "shall", "may", "might",
  "have", "has", "had",
  "isn't", "aren't", "wasn't", "weren't", "don't", "doesn't", "didn't",
  "can't", "couldn't", "shouldn't", "wouldn't", "won't", "haven't", "hasn't",
])
const subjects = new Set(["i", "you", "we", "they", "he", "she", "it", "there"])

function lastSentence(text: string): string {
  const sentences = text.split(/(?<=[.!?…])\s+/)

  return sentences[sentences.length - 1] ?? ""
}

function sentenceWords(sentence: string): string[] {
  const words = sentence
    .toLowerCase()
    .replace(/’/g, "'")
    .split(/\s+/)
    .map((word) => word.replace(/^[^a-z']+|[^a-z']+$/g, ""))
    .filter((word) => word !== "")

  const firstContentWord = words.findIndex((word) => !leadingFillers.has(word))

  return firstContentWord === -1 ? [] : words.slice(firstContentWord)
}

function soundsLikeQuestion(sentence: string): boolean {
  const [firstWord = "", secondWord = ""] = sentenceWords(sentence)

  if (questionWords.has(firstWord)) {
    return true
  }

  return auxiliaryVerbs.has(firstWord) && subjects.has(secondWord)
}

// Ends the dictation with punctuation and one space, so the next dictation
// starts a new sentence.
export function endSentence(text: string): string {
  const trimmed = text.trimEnd()

  if (trimmed === "") {
    return trimmed
  }

  if (endsWithPunctuation.test(trimmed)) {
    return `${trimmed} `
  }

  const punctuation = soundsLikeQuestion(lastSentence(trimmed)) ? "?" : "."

  return `${trimmed}${punctuation} `
}
