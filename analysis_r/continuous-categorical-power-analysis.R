function (){
  #USER SPECIFICATION PORTION
  alpha=0.05 #DESIGNATED ALPHA
  power=0.90 #NOMINAL POWER
  g=2 #NUMBER OF GROUPS
  rvec=c(1,1) #SAMPLE SIZE RATIOS
  beta1vec=c(0.39,0.34) #SLOPE COEFFICIENTS - from Luke paper Table 4  act-ext & sham
  sigsq=1 #ERROR VARIANCE - set to 1 per article
  tausqvec=c(1.5876,1.2769) #PREDICTOR VARIANCES - Table 1 ESM measures, SD(BP)^2
  #END OF SPECIFICATION
  df1<-g-1
  numint<-200
  l<-numint+1
  dd<-1e-6
  coevec<-c(1,rep(c(4,2),numint/2-1),4,1)
  set.seed(2017)
  repn<-20000
  apowerf<-function(){
    nvec<-n*rvec
    df<-sum(nvec)-2*g
    fcrit<-qf(1-alpha,df1,df)
    dfkvec<-nvec-1
    dfk<-sum(dfkvec)
    lqvec<-dfkvec/dfk
    oavec<-tausqvec*lqvec
    buw<-sum(oavec*beta1vec)/sum(oavec)
    lam<-dfk*sum(oavec*(beta1vec-buw)^2)/sigsq
    apower<-pf(fcrit,df1,df,lam,lower.tail=FALSE)
  }
  kbpowerf<-function(){
    nvec<-n*rvec
    df<-sum(nvec)-2*g
    fcrit<-qf(1-alpha,df1,df)
    dfkvec<-nvec-1
    dfk<-sum(dfkvec)
    cl<-dd
    cu<-qchisq(1-dd,dfk)
    intc<-(cu-cl)/numint
    cvec<-cl+intc*(0:numint)
    wcpdf<-(intc/3)*coevec*dchisq(cvec,dfk)
    dfb1<-cumsum(dfkvec[1:g-1])
    dfb2<-dfkvec[2:g]
    ep<-0
    for (i in seq(repn)) {
      bvec<-rbeta(df1,dfb1/2,dfb2/2)
      avec<-rep(0,g)
      avec[1]<-exp(sum(log(bvec)))
      for (ig in (2:df1)) {
        avec[ig]<-(1-bvec[ig-1])*exp(sum(log(bvec[ig:df1])))
      }
      avec[g]<-1-bvec[df1]
      oavec<-tausqvec*avec
      buw<-sum(oavec*beta1vec)/sum(oavec)
      lamvec<-cvec*sum(oavec*(beta1vec-buw)^2)/sigsq
      ep<-ep+sum(wcpdf*pf(fcrit,df1,df,lamvec,lower.tail=FALSE))
    }
    kbpower<-ep/repn
  }
  n<-3
  loop<-0
  apower<-0
  while(apower<power & loop<1000){
    n<-n+1
    loop<-loop+1
    apower<-apowerf()
  }
  n<-max(n-1,3)
  loop<-0
  kbpower<-0
  while(kbpower<power & loop<1000){
    n<-n+1
    loop<-loop+1
    kbpower<-kbpowerf()
  }
  return(list(sample_size=n*rvec,attained_power=kbpower))
}

