using PhyNEST

p=readPhylip("QUARTET.SCORTHOS.supermatrix.trimal.phy")
df=HyDe(p,"OUTGROUP", display_all=true, writecsv=true)
