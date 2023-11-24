As a result of trying to clean up the Mplus data files and records (cleanup occurring in Nov 2023), I (Jen) am making several notes to assist in reconciling files and understanding what manual procedures were used.

**Notes on files**

The Study 1 mplus data folder includes two files, August8 and August16, that are almost identical (but not quite). 

August8.dat is correctly structured but does not contain the variables needed for our test involving an interaction term, and it does not appear to have been used in any Mplus files in my possession. It has two variables in the right-most two columns that have long post-decimal digit chains; I haven't reconstructed what these variables are.

August17.dat contains the variables needed (more below) but also contains string variables, which Mplus rejects. The associated input file (6July20\_proper lags\_test lag.inp) thus throws an error. **This file needs to be corrected to remove the string variables.** Note that this file is most directly comparable to 16Nov\_Longformat.xlsx (and 16Nov\_Longformat.dat), with additional contrast codes and interaction terms added.

Mplus .dat files do not contain variable names. I created these files by saving excel files to csv and removing the variable-name column headers. The only way to identify the variables now is to refer to input files that call a particular data file. For example, using the 6July20 input file, I can ascertain that the variables in August17.dat are:

ID
t (time)
d0\_s1 (0 = David, 1 = Sarah)
impr
warm
comp
statval
statnum
Itemtype
x1 (neutral + vs valenced -)
x2 (pos + vs neg -)
x3 (comp/int + vs warm -)
x4 (comp + vs integ -)
x5 (kind + vs consid -)
x6 (incomp/lack integ - vs cold +)
x7 (incomp + vs lack integ -)
x8 (rude + vs incons -)
itemnum
Meanval1
Meanval2
int\_lag (Meanval1\*l.Meanval1)
INTERACT (int_fwd = Meanval1*f.Meanval1)


Note that the x variables are contrast codes that capture the type of behaviour.

**Files that match our results outputs and presentations**

For Study 1 (student), the dataset is new\_data.csv and the input file is Lagged interaction multilevel (0 constraint, no lagged statval).inp.

For Study 2 (prolific), the dataset is prolific-mplus-statval-attchecks.dat and the input file is prolific\_statval\_no\_x\_lag\_controls.inp.