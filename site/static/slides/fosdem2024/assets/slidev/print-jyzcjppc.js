function __vite__mapDeps(indexes) {
  if (!__vite__mapDeps.viteFileDeps) {
    __vite__mapDeps.viteFileDeps = ["assets/slidev/DrawingPreview-lUDfsxKN.js","assets/modules/vue-O-XuQLLR.js","assets/index-DENYuTHS.js","assets/modules/shiki-CBnMlxcT.js","assets/modules/shiki-BSchMNmt.css","assets/index-BAThGyva.css","assets/slidev/bottom-WehDtssn.js","assets/bottom-DbIWt59F.css"]
  }
  return indexes.map((i) => __vite__mapDeps.viteFileDeps[i])
}
import{d as m,y as c,M as F,Y as L,J as V,o as r,b as u,l as d,A as a,i as B,c as f,g as _,h as M,F as v,Z as R,e as y,f as j,C as z,_ as G}from"../modules/vue-O-XuQLLR.js";import{t as W}from"../modules/shiki-CBnMlxcT.js";import{G as D,g as I,S as O,a as T,w as H}from"./bottom-WehDtssn.js";import{s as J,a as k,_ as K,c as S,i as X,b as h,u as w,d as $,C as Y,e as N,f as g,g as Z}from"../index-DENYuTHS.js";import{P as Q}from"./PrintStyle-DYFVhmXJ.js";function U(l){return Array.from(new Set(l))}function q(...l){let t,n,e;l.length===1?(t=0,e=1,[n]=l):[t,n,e=1]=l;const s=[];let i=t;for(;i<n;)s.push(i),i+=e||1;return s}function ee(l,t){if(!t||t==="all"||t==="*")return q(1,l+1);if(t==="none")return[];const n=[];for(const e of t.split(/[,;]/g))if(!e.includes("-"))n.push(+e);else{const[s,i]=e.split("-",2);n.push(...q(+s,i?+i+1:l+1))}return U(n).filter(e=>e<=l).sort((e,s)=>e-s)}const te=["id"],ne=m({__name:"PrintSlideClick",props:{nav:{type:Object,required:!0}},setup(l){const{nav:t}=l,n=c(()=>t.currentSlideRoute.value),e=c(()=>({height:`${J.value}px`,width:`${k.value}px`})),s=F();K(()=>import("./DrawingPreview-lUDfsxKN.js").then(o=>o.a),__vite__mapDeps([0,1,2,3,4,5,6,7])).then(o=>s.value=o.default);const i=c(()=>`${n.value.no.toString().padStart(3,"0")}-${(t.clicks.value+1).toString().padStart(2,"0")}`);return L(X,V({nav:t,configs:S,themeConfigs:c(()=>S.themeConfig)})),(o,C)=>(r(),u("div",{id:i.value,class:"print-slide-container",style:M(e.value)},[d(a(D)),d(O,{is:n.value.component,"clicks-context":o.nav.clicksContext.value,class:B(a(I)(n.value)),route:n.value},null,8,["is","clicks-context","class","route"]),s.value?(r(),f(a(s),{key:0,page:n.value.no},null,8,["page"])):_("v-if",!0),d(a(T))],12,te))}}),A=h(ne,[["__file","/home/alex/notes/slides/node_modules/@slidev/client/internals/PrintSlideClick.vue"]]),se=m({__name:"PrintSlide",props:{route:{type:null,required:!0}},setup(l){const{route:t}=l,{isPrintWithClicks:n}=w(),e=$(t,n.value?0:Y);return(s,i)=>(r(),u(v,null,[d(A,{"clicks-context":a(e),nav:a(N)(s.route,a(e))},null,8,["clicks-context","nav"]),a(n)?(r(),u(v,{key:0},[_(`
      clicks0.total can be any number >=0 when rendering.
      So total-clicksStart can be negative in intermediate states.
    `),(r(!0),u(v,null,R(Math.max(0,a(e).total-a(e).clicksStart),o=>(r(),f(A,{key:o,nav:a(N)(s.route,a($)(s.route,o+a(e).clicksStart))},null,8,["nav"]))),128))],64)):_("v-if",!0)],64))}}),le=h(se,[["__file","/home/alex/notes/slides/node_modules/@slidev/client/internals/PrintSlide.vue"]]),ae={id:"print-content"},ie=m({__name:"PrintContainer",props:{width:{type:Number,required:!0}},setup(l){const t=l,{slides:n,currentRoute:e}=w(),s=c(()=>t.width),i=c(()=>t.width/g.value),o=c(()=>s.value/i.value),C=c(()=>o.value<g.value?s.value/k.value:i.value*g.value/k.value);let p=n.value;e.value.query.range&&(p=ee(p.length,e.value.query.range).map(P=>p[P-1]));const E=c(()=>({"select-none":!S.selectable}));return L(Z,C),(x,P)=>(r(),u("div",{id:"print-container",class:B(E.value)},[y("div",ae,[(r(!0),u(v,null,R(a(p),b=>(r(),f(le,{key:b.no,route:b},null,8,["route"]))),128))]),j(x.$slots,"controls")],2))}}),re=h(ie,[["__file","/home/alex/notes/slides/node_modules/@slidev/client/internals/PrintContainer.vue"]]),oe={id:"page-root",class:"grid grid-cols-[1fr_max-content]"},ce=y("div",{id:"twoslash-container"},null,-1),ue=m({__name:"print",setup(l){const{isPrintMode:t}=w();return z(()=>{t?document.body.parentNode.classList.add("print"):document.body.parentNode.classList.remove("print")}),G(()=>{W()}),(n,e)=>(r(),u(v,null,[a(t)?(r(),f(Q,{key:0})):_("v-if",!0),y("div",oe,[d(re,{class:"w-full h-full",style:M({background:"var(--slidev-slide-container-background, black)"}),width:a(H).width.value},null,8,["style","width"]),ce])],64))}}),fe=h(ue,[["__file","/home/alex/notes/slides/node_modules/@slidev/client/pages/print.vue"]]);export{fe as default};