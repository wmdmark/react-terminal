### Terminal scripting idea


```javascript
mailSignupProgram = [
  type("computer", "Hi there, what is your name?"),
  promptForVar("name"),
  type("computer", "Hi {{ name }}, enter your email address to signup."),

  "computer:type > Hi there, what is your name?",
  "computer:prompt > name",
  "computer:type > Hi {{ name }}, enter your email address to signup.",
  "computer:prompt > email",
  "action:save > email"
]
```
