let maxSlots = 1;
let characters = [];

window.addEventListener('message', (e)=>{
    const data = e.data;
    if(data.action === 'open'){
        maxSlots = data.max;
        characters = data.characters;
        buildSlots();
        document.getElementById('app').classList.remove('hidden');
    }
});

function buildSlots(){
    const container = document.getElementById('slots');
    container.innerHTML='';
    for(let i=0;i<maxSlots;i++){
        const div=document.createElement('div');
        const char=characters[i];
        if(char){
            div.className='slot filled';
            div.innerHTML=`<span>${char.firstname}<br>${char.lastname}</span>`;
            div.onclick=()=>selectCharacter(char.id);
        }else{
            div.className='slot';
            div.innerHTML='<span>Neu</span>';
            div.onclick=createCharacter;
        }
        container.appendChild(div);
    }
}

function selectCharacter(id){
    fetch(`https://${GetParentResourceName()}/selectCharacter`,{
        method:'POST',
        headers:{'Content-Type':'application/json'},
        body:JSON.stringify(id)
    });
    closePanel();
}

function createCharacter(){
    const firstname=prompt('Vorname?');
    const lastname=prompt('Nachname?');
    const dob=prompt('Geburtsdatum (YYYY-MM-DD)?');
    const gender=prompt('Geschlecht (m/f)?');
    if(firstname&&lastname&&dob&&gender){
        fetch(`https://${GetParentResourceName()}/createCharacter`,{
            method:'POST',
            headers:{'Content-Type':'application/json'},
            body:JSON.stringify({firstname,lastname,dob,gender})
        });
        closePanel();
    }else{
        alert('Alle Felder ausfüllen!');
    }
}

function closePanel(){
    document.getElementById('app').classList.add('hidden');
}
