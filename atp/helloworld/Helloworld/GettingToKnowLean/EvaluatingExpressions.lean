#eval 1 + 2
#eval 1 + 2 * 5
#eval String.append "Hello, " "Lean!"
#eval String.append "it is " (if 1 > 2 then "yes" else "no")
#eval String.append "A" (String.append "B" "C")
#eval String.append (String.append "A" "B") "C"
#eval if 3 == 4 then "equal" else "not equal"
