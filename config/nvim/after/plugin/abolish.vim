if !exists(":Abolish")
  finish
endif

" Code syntax.
Abolish cosnt const
Abolish flase false

" English words.
Abolish despara{te,tely,tion}                despera{}
Abolish reponse{,s}                          response{}
Abolish seperat{e,es,ed,ing,ely,ion,ions,or} separat{}
Abolish {,in}consistan{cy,cies,t,tly}        {}consisten{}
Abolish {,non}existan{ce,t}                  {}existen{}
Abolish {,un}orgin{,al,ally}                 {}origin{}
Abolish {c,m}arraige{,s}                     {}arriage{}

" Swedish words.
Abolish brevid                                     bredvid
Abolish definer{a,ar,ade,at,ande,ad,at}            definier{}
Abolish hit{,t}il{,l}s                             hittills
Abolish häl{st,lre}                                hel{st,lre}
Abolish iakt{,t}{a,ar,og,agit}                     iakt{t}{}
Abolish iallafall                                  i alla fall
Abolish igentligen                                 egentligen
Abolish nog{,g}ra{,n}{,n,nt,na,nare,nast,naste}    nog{g}ra{n}{n,n,nt,na,nare,nast,naste}
Abolish näm{a,ande,d,de,dade,er,t}                 nämn{}
Abolish religös{,a,are,ast,aste,t}                 religiös{}
Abolish sugne                                      sugen
Abolish tillfredställ{,a,ande,as,da,de,er,es,t,ts} tillfredsställ{}
Abolish tvu{,n}g{en,et,na}                         tvu{n}g{}
Abolish ytterlig{,g}{,a,are,ast,aste,t}            ytterlig{,}{}
