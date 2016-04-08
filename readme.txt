Multicurve ABC fitter notes
---------------------------

The tool takes an input file CurveData.csv which (a single list of spend values (x) and multiple columns (y1, y2, ..., yn) 

of revenue) and fits the functional form y=A/(1+B*C^x) for each combination of x and y. The expected output is an ABC.csv 

file containing these coeffeicents, and a pseudo R2 value, a measure of fit. The tool first attempts to fit a curve via 

NLS, but if the the data is too deviant from a typical ABC curve, it will fail. In this scenario an optimisation method is 

used to force the best ABC curve onto the data.

Current bugs and limitations
----------------------------

1) No data validation. The following must occur:
	
	* Second row (under titles) must be all zeroes
	* Monotonic increasing spend column
	* No additional values or entries other than those to be calculated

2) C coefficient can vary wildly if NLS fitting fails. Contraint required to limit to more sensible range (-0.5 < C < -1.5)

3) Add type of fit to output - currently stored in 'type' vector 

4) Manual R interface, R Shiny output planned

   
