/* Project-local Mote pack: original Pip vectors, no external media or ledger input. */
(()=>{
const definitions=[['quiet','Quiet Companion'],['guy','Your Guy'],['girl','Girl’s Girl'],['coach','The Coach']];
globalThis.GallyPipMotePack={id:'gally-pip',name:'Pip',version:'1.0.0',description:'Original Gally companion artwork',baseShapes:[],shapes:definitions.map(([id,label])=>({id:'pip-'+id,label:'Pip · '+label,kind:'obj',ar:320/336,render:()=>PipCharacter.svg('ready',{look:id}).replace('<svg ','<svg style="display:block;width:100%;height:100%;overflow:visible" ')})),themes:{light:[{f:'#DFF3E9',d:'#184D3D',w:1}],dark:[{f:'#DFF3E9',d:'#184D3D',w:1}]}};
})();
