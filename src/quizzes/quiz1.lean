/-
CS2120 Fall 2022 Sullivan. Quiz #1. Edit your answers into
this file using VSCode. Save the file to your *local* hard 
drive (File > Save As > local > ...). Submit it to the Quiz1
assignment on Collab.
-/

/-
#1: For each of the following questions give a yes/no answer 
and then a very brief explanation why that answer is correct.
To explain why your answer is correct, name the specific rule
of inference that tells you it's correct, or explain that 
there is no such valid inference rule.
-/

/-
#1A

If a ball, b, is round *and* b is also red, is b red?
P ∧ Q → Q
A: yes/no: Yes

B: Why? And-elimination


#1B

If flowers make you happy and chocolates make you happy,
and I give you flowers *or* I give you chocolates, will
you be happy?
A = Flowers make you happy, B = chocolates make you happy, C = give you flowers, D = give you chocolate
A ∧ B, C ∨ D →  

A: yes/no: Yes

B: Why? Or introduction


#1C: If giraffes are just zebras in disguise, then the 
moon is made of green cheese?

A. yes/: Yes

B. Why? False elimination, since the first proposition is false, then anything goes


#1D. If x = y implies that 0 = 1, then is it true that
x ≠ y?
(P → Q) ⊢ ¬ P
A. yes/no: No

B. Why? It is a contradiction to say that if P is true and it implies Q, then P is false. There is no rule to allow for the statement above.



#1E. If every zebra has stripes and Zoe is a Zebra then
Zoe has stripes.
P ∧ Q ⊢ Q
P ∧ Q ⊢ P
P is true, Q is true, so you can deduce P and Y is true
A. yes/no: Yes

B. Why? And introduction


#1F. If Z could be *any* Zebra and Z has stripes, then 
*every* Zebra has stripes.
Z: zebra
P → 
A. Yes/no: No

B: Why? There is no inference rule that allows a deduction of one to apply to every


#1G. If whenever the wind blows, the leaves move, and 
the leaves are moving, then the wind is blowing.
P → Q, Q ⊢ P
A. yes/no: Yes

B. Why? Affirming the conclusion inference rule


#1H: If Gina is nice *or* Gina is tall, and Gina is nice,
then Gina is not tall. (The "or" here is understood to be
the or of predicate logic.)
P ∨ Q, P → ¬Q
A. yes/no: No

B. Why? Affirming the disjunct
-/



/- 
#2

Consider the following formula/proposition in propositional
logic: X ∨ ¬Y.
X = True, Y = True
#2A: Is it satisfiable? If so, give a model (a binding of 
the variables to values that makes the expressions true).
It is satisfiable. X=False, Y=False

#2B: Is it valid? Explain your answer. 
It is not valid because when X=False and Y=True, the result is False.

-/


/-
#3: 

Express the following propositions in predicate logic, by
filling in the blank after the #check command.

If P and Q are arbitrary (any) propositions, then if (P is 
true if and only if Q is true) then if P is true then Q is 
true.
-/

#check ∀ (P Q: Prop), (P ↔ Q) → P → Q




/-
#4 Translate the following expressions into English.
The #check commands are just Lean commands and can
be ignored here. 
-/


-- A
#check ∀ (n m : ℕ), n < m → m - n > 0

/-
Answer: If there are any natural numbers n and m, then if n is less than m then m - n is greater than 0
-/

-- B

#check ∃ (n : ℕ), ∀ (m : nat), m >= n

/-
Answer: Every n is a natural number that exists, and for all natural numbers n, m is greater than or equal to n
-/


-- C

variables (isEven: ℕ → Prop) (isOdd: ℕ → Prop)
#check ∀ (n : ℕ), isEven n ∨ isOdd n

/-
Answer: For any arbitrary natural number n, it is true that n is either even or odd
-/


-- D

#check ∀ (P : Prop), P ∨ ¬P

/-
Answer: for any proposition P, P is itself or it is not itself
-/


-- E

#check ∀ (P : Prop), ¬(P ∧ ¬P)

/-
Answer: For any proposition P, P is never itself and not itself
-/


/-
#5 Extra Credit

Next we define contagion as a proof of a slightly long
proposition. Everything before the comma introduces new
terms, which are then used after the comma to state the
main content of the proposition. 

Using the names we've given to the variables to infer
real-world meanings, state what the logic means in plain
natural English. Please don't just give a verbatim reading
of the formal logic. 
-/

variable contagion : 
  ∀ (Animal : Type)  -- for any animal
  (hasVirus : Animal → Prop)  -- proposiiton of hasVirus that takes Animal
  (a1 a2 : Animal) -- a1 and a2 are animals
  (hasVirus : Animal → Prop) -- proposition that takes Animal
  (closeContact : Animal → Animal → Prop), -- proposition takes animal and returns? proposition
  hasVirus a1 → closeContact a1 a2 → hasVirus a2

If the animal a1 has the virus, 
then it will be checked to see if it was in contact with another animal a2. 
If the animal a1 was in close contact with a2, then the animal a2 will be checked for the virus.
