/-

As a reminder, here are the inference rules (and a few
"logical fallacies" that you tested for validity in the
setting of propositional logic, where the variables are
all Boolean, and where logical connectives correspond to
Boolean operations, such as &&, ||, and ! (C, C++, etc.) 

1. X ∨ Y, X ⊢ ¬Y             -- affirming the disjunct
2. X, Y ⊢ X ∧ Y              -- and introduction
3. X ∧ Y ⊢ X                 -- and elimination left
4. X ∧ Y ⊢ Y                 -- and elimination right
5. ¬¬X ⊢ X                   -- negation elimination 
6. ¬(X ∧ ¬X)                 -- no contradiction
7. X ⊢ X ∨ Y                 -- or introduction left
8. Y ⊢ X ∨ Y                 -- or introduction right
9. X → Y, ¬X ⊢ ¬ Y           -- denying the antecedent
10. X → Y, Y → X ⊢ X ↔ Y      -- iff introduction
11. X ↔ Y ⊢ X → Y            -- iff elimination left
12. X ↔ Y ⊢ Y → X            -- iff elimination right
13. X ∨ Y, X → Z, Y → Z ⊢ Z  -- or elimination
14. X → Y, Y ⊢ X             -- affirming the conclusion
15. X → Y, X ⊢ Y             -- arrow elimination
16. X → Y, Y → Z ⊢ X → Z     -- transitivity of → 
17. X → Y ⊢ Y → X            -- converse
18. X → Y ⊢ ¬Y → ¬X          -- contrapositive
19. ¬(X ∨ Y) ↔ ¬X ∧ ¬Y       -- DeMorgan #1 (¬ distributes over ∨)
20. ¬(X ∧ Y) ↔ ¬X ∨ ¬Y       -- Demorgan #2 (¬ distributes over ∧)
-/


/-
Here we present the familiar inference rules above but 
now in the context of the more expressive, higher-order
predicate logic of the Lean Prover tool. A big benefit 
is that "Lean" checks the syntax of our expressions.

Note that we've reordered the inference rules you've already
seen, putting all of the inference rules related to any given
connective or quantifier together.

We've also added inference rules for the quantifiers, ∀ and
∃, which of course are not relevant in propositional logic 
but that are essential in predicate logic (whether first- or
higher-order).

We've also separate out, and present first, the fundamental
inference rules from "inference rules" that are can be proved
using the fundamental rules. These rules are thus "theorems,"
not "axioms." 
-/

/-
Ok. So each of the following lines does the following. As you
read this, look at the first definition, of and_introduction.

In Lean, we can use "def," a Lean keywork, to start to define
the meaning/value of a variable. After "def" comes the name of
the variable. Here it's and_introduction. Next comes what we
have already seen, albeit briefly: a type judgment, comprising
a colon followed by a type name. The type name in this case is
"Prop," which is the type of all *propositions* in Lean. So far
then we've told Lean that we're going to define and_introduction
to be a variable the value of which is a proposition. Next is 
a :=, which is the Lean operator for binding a value to a name.
Finally, the value to be bound is to the right. In this case,
as expected, it's a proposition. 

The particular proposition in this case is what we can call a 
"universal generalization" in that it starts with a ∀. The ∀ 
introduces two new variable names, X and Y, with a type judgment
stating that their values are propositions, indeed they can be
*any* propositions whatsoever. Finally, in the context of the
assumption that X and Y are arbitrary (any) proposition, the
rule states that if we assume that we are given a proof of X
(the analog of the assumption that X is true in propositional
or first-order predicate logic), and if in that context we then
further assume that we have a proof of Y (and thus that Y is 
also true), then in that context, we can construct a proof of
X ∧ Y, thus concluding that it, too, must be true.  
-/

-- ∧ 
def and_introduction  : Prop  := ∀ (X Y : Prop), X → Y → (X ∧ Y)
def and_elim_left     : Prop  := ∀ (X Y : Prop), X ∧ Y → X  
def and_elim_right    : Prop  := ∀ (X Y : Prop), X ∧ Y → Y  

/-
Note that we are able to express these rules of logic very
naturally in higher-order constructive logic because we can
quantify over propositions. You cannot write these definitions
in first-order logic because it doesn't allow you to do this.
Such an expression is a syntax error in first-order logic. 
-/

/- A LEAN DETAIL and IMPORTANT LANGUAGE DESIGN CONCEPT
A good language gives you good ways not to repeat yourself.
We can avoid having to repeatedly write "∀ (X Y : Prop),"
by creating a "section" in a Lean file, and declaring the
common variables once at the top. Lean then implicitly adds
a "∀ (X : Prop)" at the beginning of any expression that has
an X in it (and the same goes for Y and Z in this file).
I
-/

section pred_logic

variables X Y Z : Prop

/-
In your mind, be sure to recognize that every one of the
following propositions now has an implicit ∀ in front. The
or_intro_left definition that comes next, for example, means 
def or_intro_left : Prop := ∀ (X Y : Prop), X → X ∨ Y. 
-/

-- ∨ 
def or_intro_left : Prop    := X → X ∨ Y
def or_intro_right : Prop   := Y → X ∨ Y
def or_elim : Prop          := (X ∨ Y) → (X → Z) → (Y → Z) → Z

/-
Lean, and other languages like it, also allow you to drop
explicit type judgments when they can be inferred from the
context. In the rest of this file, we also drop the ": Prop"
explicit type judgments because Lean can figure our from the
values that follow the :='s that type types of the variables
here just have to be Prop.
-/

-- ↔ 
def iff_intro         := (X → Y) → (Y → X) → X ↔ Y

/-
You can read this rule both forward (left to right) and 
backwards. Reading forwards, it says that if you have a
proof (or know the truth) of X → Y, and you have a proof
(or know the truth) of Y → X, then you can derive of a proof
(deduce the truth) of X ↔ Y.

The more important direction in practice is to read it
from right to left. What it says in this reading is that
if you want to prove X ↔ Y, then it will suffice to have
two "smaller" proofs: one of X → Y and one of Y → X. 

From now on, whenever you're asked to prove equivalence
of two propositions, X and Y, you'll thus start by saying,
"It will suffice to prove the implication in each direction."
Then you end up with two smaller goals to prove, one in 
each direction. So, "We first consider X → Y." Then give
a proof of it. Then, "Next we consider Y → X." Then give
a proof of it. And finally, "Having proven the implication
in each direction (by application of the rule of ↔ intro)
we've completed our proof. QED."
-/

def iff_elim_left     := X ↔ Y → (X → Y)
def iff_elim_right    := X ↔ Y → (Y → X)

/-
The elimination rules are also easy. Given X ↔ Y, you can
immediately deduce X → Y and Y → X.
-/

-- → and ∀ 
def arrow_all_equiv   := (∀ (x : X), Y) ↔ (X → Y)

/-
To prove either (∀ (x : X), Y) or (X → Y), you first assume  
that you're given an arbitrary but specific proof of X, and
in that context, you show that you can derive a proof (thus 
deducing the truth) of Y. It's exactly the same reasoning in
each case. This is the *introduction* rule for ∀ and →. 
-/

/-
In fact, in constructive logic, X → Y is simply a notation
*defined* as ∀ (x : X), Y. What each of these propositions 
states in constructive logic is that "From *any* proof, x, 
of X, we can derive a proof of Y." In fact, in Lean, these
propositions are not only equivalent but equal. 
-/

#check X → Y          -- Lean confirms this is a proposition
#check ∀ (x : X), Y   -- Lean understands this to say X → Y!

/- OPTIONAL
As an aside, here's a proof that these propositions are 
actually equal. This proof uses an inference rule, rfl, for 
equality that we've not yet studied. Don't worry about the 
"rfl" for now, but trust that we're giving a correct proof
of the equality of these two propositions in Lean
-/
theorem all_imp_equal : (∀ (x : X), Y) = (X → Y) := rfl 

/-
The reason it's super-helpful to know these propositions 
are equivalent is that it tells you that you can *use* a 
proof of a ∀ proposition or of a → proposition in exactly
the same way. So let's turn to the *elimination* rules for
→ and ∀. 
-/

def arrow_elim        := (X → Y)        → X   → Y
def all_elim          := (∀ (x : X), Y) → X   → Y

/-
The idea underlying these rules date to ancient times. 
They both say "if from the truth or a proof of X you 
can derive a proof or the truth of Y, and if you also 
have a proof, or know the truth, of X, then you can (in
constructive logic) derive a proof of Y (or deduce the
truth of Y." 

Here's an example. What we want to say in logic is
that if every ball is blue and b is some specific 
ball then b is blue. The elimination rule for ∀ and
→ applies a generalization to a specific instance to
deduce that the generalized statement specialized to
a particular instance is true.

Note: In this example, Y is a proposition obtained by 
plugging "x" into a one-argument predicate. So suppose 
(∀ (x : X), Y) is read as "for any Ball x, x is blue."  
Here X is "Ball;" x is an arbitrary but specific Ball; 
and Y is read as "x is blue." 
  
Now suppose that, in this context, you're given a 
*particular* ball, (b : X). What the overall rules
says is that you now conclude that "b is blue."

The elimination rule works by *applying* a proof of
a universal generalization (showing that something
is true of *every* object of a particular kind) to 
a *specific* object of that kind, to deduce that the 
generalized statement is also true of that specific
object.

If every ball is blue, and if b is a ball, then b
must be blue. Another way to say it that makes a
bit more sense for the (X → Y) notation is that 
"if being any ball, x, implies that x is blue, and 
if b is some particular ball, then b is blue.
-/

/-
The inference rules for and, or, implies, forall, and
biimplication are "not to bad." The rules for negation
and exists are a little trickier: not terrible but they
do require slightly deeper understanding. 
-/

-- ¬ 
def not_ (X : Prop) := X → false  -- this is how "not" ¬ is defined in CL
def excluded_middle   := X ∨ ¬X   -- not an axiom in constructive logic
def neg_elim          := ¬¬X → X  -- depends on adoption of em as an axiom

/-
And for this explanation, we need to nail down the concept of a 
predicate in predicate logic. As we've exaplained before, a predicate 
is a proposition with one or more parameters. Think of parameters as 
blanks in the reading of a proposition that you can fill in with any 
value of the type of value permitted in that slot. When you fill in 
all the blanks (by giving actual values for the formal parameters),
you get a proposition: a specific statement about specific objects 
with no remaining blanks to be filled in. A predicate gives rise to 
a family of propositions. Once all the parameters in a predicate are
bound to actual values, you've no longer got a predicate, but just a
proposition. 
-/

/-
As an example, consider a predicate, (isBlue _), where you can fill
in the blank/argument with any Ball-type object. If b is a specific
Ball-type object, then (isBlue b) is a proposition, representing the
English-language claim that b is blue. Here's how we represent this
predicate in Lean.
-/

variable Ball : Type            -- Ball is a type of object
variable isBlue : Ball → Prop
/-
First we Ball to be the name of a type of object (like int or 
bool). Then we define isBlue to be a construct (think function!)
that when given any object of type Ball as an argument yields a
proposition. To see how this works, suppose we have some specific
balls, b1 and b2.
-/
variables (b1 b2 : Ball)
/-
Now let's use isBlue to make some propositions!
-/
#check isBlue                               -- a predicate
#check isBlue b1                            -- a proposition about b1
#check isBlue b2                            -- a proposition about b2
#check (∀ (x : Ball), isBlue x)             -- generalization
variable all_balls_blue : (∀ (x : Ball), isBlue x)   -- proof of it
#check all_balls_blue b1                    -- proof b1 is blue
#check all_balls_blue b1                    -- proof b2 is blue

/-
Walk-away message: Applying a proof/truth of a universal
generalization to a specific object yields a proof of the
generalization *specialized* to that particular object.
-/

/-
Quiz questions:

First-order logic. I know that every natural number is
beautiful (∀ n, NaturalNumber(n) → Beautiful(n) : true), 
and I want to prove (7 is beautiful : true). Prove it.
Name the inference rule and identify the arguments you
give it to prove it.

Constructive logic. Suppose I have a proof, pf, that every 
natural number is beautiful (∀ (n : ℕ), beautiful n), and I 
need a proof that 7 is beautiful. How can I get the proof 
I need? Answer in both English and with a Lean expression.
-/


-- ∃
def exists_intro := ∀ {P : X → Prop} (w : X), P w → (∃ (x : X), P x) 
def exists_elim := ∀ {P : X → Prop}, (∃ (x : X), P x) → (∀ (x : X), P x → Y) → Y 

/-
That's it for the fundamental rules of higher-order predicate
logic. The constructive logic versions of the remaining inference
rules we saw in propositional logic are actually theorems, which
means that they can be proved using only the fundamental rules,
which we accept as axioms. An axiom is a proposition accepted as
true without a proof. The inference rules of a logic are accepted
as axioms. The truth of any other proposition in predicate logic
(the foundation for most of mathematics) is proved by applying 
fundamental axioms and previously proved theorems..  
-/

-- theorems
def arrow_trans       := (X → Y) → (Y → Z) → (X → Z)
def contrapostitive   := (X → Y) → (¬Y → ¬X)
def demorgan1         := ¬(X ∨ Y) ↔ ¬X ∧ ¬Y
def demorgan2         := ¬(X ∧ Y) ↔ ¬X ∨ ¬Y
def no_contradiction  := ¬(X ∧ ¬X)


/-
Here are the logical fallacies we first met in propositional
logic, now presented in the much richer context of constructive
logic. You might guess that it will be impossible to construct
proofs of these fallacies, and you would be correct, as we will
see going forward.
-/
-- fallacies
def converse          := (X → Y) → (Y → X)
def deny_antecedent   := (X → Y) → ¬X →  ¬Y
def affirm_conclusion := (X → Y) → (Y → X)
def affirm_disjunct   := X ∨ Y → (X → ¬Y)

end pred_logic