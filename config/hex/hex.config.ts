import { defineHexConfig } from "@hex/commands"
import { endSentence } from "./sentence-end.ts"

export default defineHexConfig({
  transformations: {
    "end-with-period": {
      name: "End sentence",
      description: "End the dictation with a period, or a question mark when it starts like a question, and a space",
      transform: endSentence,
    },
  },
})
