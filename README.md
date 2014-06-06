# Mortgage cost calculator

A few years back whilst buying my first house I was looking for some sort of 
mortgage calculator to churn out the basics of what interest and capital I'd be 
paying off over the term of different mortgage deals available to me.

I couldn't find anything, and seeing as the word "mortgage" in French pretty 
much translates to "death pledge" I though it was a good idea to get it right!

So, fed up of getting the calculator out again and again I mocked up this quick 
and dirty perl script, which is essentially for just fixed interest rate deals 
but can be used to estimate tracker types too.

##Parameters are:

* mortgage_value *-m*		Value of the mortgage (i.e. Property value minus Deposit)
* arrangement_fee *-a*		Any arrangement fee on the initial mortgage
* interest_rate *-i*		The rate in percent of the initial mortgage deal
* interest_rate_term *-it*	The term for the initial interest rate
* term *-t*			The total term of the mortgage (defaults to 25 years)
* interest_rate_increase *-ii*	A yearly increase for the interest rate outside of the initial fixed term
* cap_rate_increase *-ic*		Cap the yearly interest increase at a particular value
* monthly_overpayment *-o*	The value of any regular monthly overpayments you intend to make
* monthly_payment *-p*		An amount you decide you want to pay off each month (calculated from mortgage value, rate and term otherwise)

##Example usage

The simplest input for the script is just a mortgage value and an interest rate; the
script then defaults to a 25 year term at the same fixed rate.  So if I wanted a house
costing £105k with a £5k deposit with a fixed 3.2% rate (obviously this isn't much use 
but just for illustration):

<pre>
$ ./mcalc.pl -m=100000 -i=3.2

Mortgage value: 100000
Arrangement fee added on: 0
Term: 25 year(s)
Interest rate: 3.2% (Monthly rate = 0.00266666666666667%)
Interest rate term: 1 years
Initial monthly payment: 484.68
After initial term rate jumps by: 0
---------------------------------------
Total mortgage value: 100000
---------------------------------------

End of year 1    Mortgage: 97345.14   Total paid: 5816.15    Total interest: 3154.21     (Rate 3.2%, Monthly Payment 484.68)
End of year 2    Mortgage: 94433.05   Total paid: 11800.81   Total interest: 6219.02     (Rate 3.2%, Monthly Payment 498.72)
End of year 3    Mortgage: 91426.40   Total paid: 17785.48   Total interest: 9189.02     (Rate 3.2%, Monthly Payment 498.72)
End of year 4    Mortgage: 88322.11   Total paid: 23770.15   Total interest: 12061.12    (Rate 3.2%, Monthly Payment 498.72)
End of year 5    Mortgage: 85117.02   Total paid: 29754.81   Total interest: 14832.14    (Rate 3.2%, Monthly Payment 498.72)
End of year 6    Mortgage: 81807.84   Total paid: 35739.48   Total interest: 17498.81    (Rate 3.2%, Monthly Payment 498.72)
End of year 7    Mortgage: 78391.21   Total paid: 41724.14   Total interest: 20057.73    (Rate 3.2%, Monthly Payment 498.72)
End of year 8    Mortgage: 74863.62   Total paid: 47708.81   Total interest: 22505.40    (Rate 3.2%, Monthly Payment 498.72)
End of year 9    Mortgage: 71221.48   Total paid: 53693.47   Total interest: 24838.21    (Rate 3.2%, Monthly Payment 498.72)
End of year 10   Mortgage: 67461.07   Total paid: 59678.14   Total interest: 27052.44    (Rate 3.2%, Monthly Payment 498.72)
End of year 11   Mortgage: 63578.54   Total paid: 65662.81   Total interest: 29144.22    (Rate 3.2%, Monthly Payment 498.72)
End of year 12   Mortgage: 59569.94   Total paid: 71647.47   Total interest: 31109.59    (Rate 3.2%, Monthly Payment 498.72)
End of year 13   Mortgage: 55431.16   Total paid: 77632.14   Total interest: 32944.44    (Rate 3.2%, Monthly Payment 498.72)
End of year 14   Mortgage: 51157.97   Total paid: 83616.80   Total interest: 34644.53    (Rate 3.2%, Monthly Payment 498.72)
End of year 15   Mortgage: 46746.03   Total paid: 89601.47   Total interest: 36205.49    (Rate 3.2%, Monthly Payment 498.72)
End of year 16   Mortgage: 42190.81   Total paid: 95586.13   Total interest: 37622.79    (Rate 3.2%, Monthly Payment 498.72)
End of year 17   Mortgage: 37487.67   Total paid: 101570.80  Total interest: 38891.77    (Rate 3.2%, Monthly Payment 498.72)
End of year 18   Mortgage: 32631.80   Total paid: 107555.47  Total interest: 40007.62    (Rate 3.2%, Monthly Payment 498.72)
End of year 19   Mortgage: 27618.25   Total paid: 113540.13  Total interest: 40965.36    (Rate 3.2%, Monthly Payment 498.72)
End of year 20   Mortgage: 22441.88   Total paid: 119524.80  Total interest: 41759.86    (Rate 3.2%, Monthly Payment 498.72)
End of year 21   Mortgage: 17097.42   Total paid: 125509.46  Total interest: 42385.81    (Rate 3.2%, Monthly Payment 498.72)
End of year 22   Mortgage: 11579.41   Total paid: 131494.13  Total interest: 42837.75    (Rate 3.2%, Monthly Payment 498.72)
End of year 23   Mortgage: 5882.21    Total paid: 137478.80  Total interest: 43110.02    (Rate 3.2%, Monthly Payment 498.72)
End of year 24   Mortgage: -0.00      Total paid: 143463.46  Total interest: 43196.79    (Rate 3.2%, Monthly Payment 498.72)
Paid off in month 12 of year 24

</pre>

A more useful example would be to also specify all the other usual variables, 
so lets also specify a mortgage term of 20 years, with an initial mortgage deal
of 3.2% fixed for 3 years with a £995 arrangement fee, after the fixed deal
ends lets assume the rate increases by 0.4% each year plateauing at 7%:

<pre>

$ ./mcalc.pl -m=100000 -a=995 -t=20 -i=3.2 -it=3 -ii=0.4 -ic=7

Mortgage value: 100000
Arrangement fee added on: 995
Term: 20 year(s)
Interest rate: 3.2% (Monthly rate = 0.00266666666666667%)
Interest rate term: 3 years
Initial monthly payment: 570.28
After initial term rate jumps by: 0.4
---------------------------------------
Total mortgage value: 100995
---------------------------------------

End of year 1    Mortgage: 97330.02   Total paid: 6843.37    Total interest: 3168.62     (Rate 3.2%, Monthly Payment 570.28)
End of year 2    Mortgage: 93546.03   Total paid: 13686.75   Total interest: 6217.92     (Rate 3.2%, Monthly Payment 570.28)
End of year 3    Mortgage: 89639.16   Total paid: 20530.12   Total interest: 9144.00     (Rate 3.2%, Monthly Payment 570.28)
End of year 4    Mortgage: 85418.81   Total paid: 27908.29   Total interest: 12289.17    (Rate 3.6%, Monthly Payment 614.85)
End of year 5    Mortgage: 81176.36   Total paid: 35490.29   Total interest: 15614.56    (Rate 4%, Monthly Payment 631.83)
End of year 6    Mortgage: 76885.59   Total paid: 43266.97   Total interest: 19084.74    (Rate 4.4%, Monthly Payment 648.06)
End of year 7    Mortgage: 72519.22   Total paid: 51228.62   Total interest: 22662.55    (Rate 4.8%, Monthly Payment 663.47)
End of year 8    Mortgage: 68048.39   Total paid: 59364.89   Total interest: 26308.62    (Rate 5.2%, Monthly Payment 678.02)
End of year 9    Mortgage: 63442.13   Total paid: 67664.83   Total interest: 29980.80    (Rate 5.6%, Monthly Payment 691.66)
End of year 10   Mortgage: 58666.70   Total paid: 76116.88   Total interest: 33633.55    (Rate 6%, Monthly Payment 704.34)
End of year 11   Mortgage: 53684.93   Total paid: 84708.87   Total interest: 37217.20    (Rate 6.4%, Monthly Payment 716.00)
End of year 12   Mortgage: 48455.39   Total paid: 93427.99   Total interest: 40677.15    (Rate 6.8%, Monthly Payment 726.59)
End of year 13   Mortgage: 42895.27   Total paid: 102203.85  Total interest: 43860.45    (Rate 7%, Monthly Payment 731.32)
End of year 14   Mortgage: 36933.21   Total paid: 110979.71  Total interest: 46639.47    (Rate 7%, Monthly Payment 731.32)
End of year 15   Mortgage: 30540.14   Total paid: 119755.57  Total interest: 48984.98    (Rate 7%, Monthly Payment 731.32)
End of year 16   Mortgage: 23684.93   Total paid: 128531.43  Total interest: 50865.63    (Rate 7%, Monthly Payment 731.32)
End of year 17   Mortgage: 16334.14   Total paid: 137307.29  Total interest: 52247.83    (Rate 7%, Monthly Payment 731.32)
End of year 18   Mortgage: 8451.97    Total paid: 146083.15  Total interest: 53095.54    (Rate 7%, Monthly Payment 731.32)
End of year 19   Mortgage: 0.00       Total paid: 154859.01  Total interest: 53370.13    (Rate 7%, Monthly Payment 731.32)

</pre>

Lets now assume we manage to make a £75 overpayment each month:

<pre>

$ ./mcalc.pl -m=100000 -a=995 -t=20 -i=3.2 -it=3 -ii=0.4 -ic=7 -o=75

Mortgage value: 100000
Arrangement fee added on: 995
Term: 20 year(s)
Interest rate: 3.2% (Monthly rate = 0.00266666666666667%)
Interest rate term: 3 years
Initial monthly payment: 570.28
After initial term rate jumps by: 0.4%
Cap rate jumps at: 7%
---------------------------------------
Total mortgage value: 100995
---------------------------------------

End of year 1    Mortgage: 96416.70   Total paid: 6843.37    Total interest: 3152.87     (Rate 3.2%, Monthly Payment 570.28 Overpayment 75.00)
End of year 2    Mortgage: 91689.74   Total paid: 13686.75   Total interest: 6156.67     (Rate 3.2%, Monthly Payment 570.28 Overpayment 75.00)
End of year 3    Mortgage: 86809.27   Total paid: 20530.12   Total interest: 9006.56     (Rate 3.2%, Monthly Payment 570.28 Overpayment 75.00)
End of year 4    Mortgage: 81807.16   Total paid: 27675.37   Total interest: 12034.69    (Rate 3.6%, Monthly Payment 595.44 Overpayment 75.00)
End of year 5    Mortgage: 76827.39   Total paid: 34936.78   Total interest: 15199.74    (Rate 4%, Monthly Payment 605.12 Overpayment 75.00)
End of year 6    Mortgage: 71848.12   Total paid: 42296.84   Total interest: 18462.27    (Rate 4.4%, Monthly Payment 613.34 Overpayment 75.00)
End of year 7    Mortgage: 66847.77   Total paid: 49736.84   Total interest: 21781.92    (Rate 4.8%, Monthly Payment 620.00 Overpayment 75.00)
End of year 8    Mortgage: 61804.83   Total paid: 57236.81   Total interest: 25117.09    (Rate 5.2%, Monthly Payment 625.00 Overpayment 75.00)
End of year 9    Mortgage: 56697.73   Total paid: 64775.21   Total interest: 28424.56    (Rate 5.6%, Monthly Payment 628.20 Overpayment 75.00)
End of year 10   Mortgage: 51504.80   Total paid: 72328.74   Total interest: 31659.20    (Rate 6%, Monthly Payment 629.46 Overpayment 75.00)
End of year 11   Mortgage: 46204.32   Total paid: 79871.84   Total interest: 34773.55    (Rate 6.4%, Monthly Payment 628.59 Overpayment 75.00)
End of year 12   Mortgage: 40774.90   Total paid: 87376.02   Total interest: 37717.53    (Rate 6.8%, Monthly Payment 625.35 Overpayment 75.00)
End of year 13   Mortgage: 35166.64   Total paid: 94760.84   Total interest: 40361.39    (Rate 7%, Monthly Payment 615.40 Overpayment 75.00)
End of year 14   Mortgage: 29152.97   Total paid: 102145.67  Total interest: 42597.47    (Rate 7%, Monthly Payment 615.40 Overpayment 75.00)
End of year 15   Mortgage: 22704.57   Total paid: 109530.50  Total interest: 44396.29    (Rate 7%, Monthly Payment 615.40 Overpayment 75.00)
End of year 16   Mortgage: 15790.02   Total paid: 116915.33  Total interest: 45726.22    (Rate 7%, Monthly Payment 615.40 Overpayment 75.00)
End of year 17   Mortgage: 8375.61    Total paid: 124300.16  Total interest: 46553.39    (Rate 7%, Monthly Payment 615.40 Overpayment 75.00)
End of year 18   Mortgage: 425.21     Total paid: 131684.99  Total interest: 46841.45    (Rate 7%, Monthly Payment 615.40 Overpayment 75.00)
End of year 19   Mortgage: -262.71    Total paid: 132300.39  Total interest: 46839.92    (Rate 7%, Monthly Payment 615.40 Overpayment 75.00)
Paid off in month 1 of year 19

</pre>

Apparently that 75 quid overpayment brings down the compulsory payments in the,
second half of the term by £100 and shaves a year off the mortage term.

Revisiting this script again now a few years later I could still sit here plugging
in different variables and seeing how it affects the payments in ways I'd never have
thought of otherwise.  I also notice it's far from the greatest example of perl 
scripting ever; if I ever get time I'll rewrite it.
