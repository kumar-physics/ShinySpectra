

xx3to1<-function(aa){
  aa3to1<-list('ALA'='A','ARG'='R','ASN'='N','ASP'='D','CYS'='C',
               'GLU'='E','GLN'='Q','GLY'='G','HIS'='H','ILE'='I',
               'LEU'='L','LYS'='K','MET'='M','PHE'='F','PRO'='P',
               'SER'='S','THR'='T','TRP'='W','TYR'='Y','VAL'='V')
  outd<-aa3to1[aa]
  return(as.character(outd))
}