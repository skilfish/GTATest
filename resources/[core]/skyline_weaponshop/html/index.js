var Licenses;
var loadout;
var Config;


// nesuprantu ka daro bet reikia idetik
function closeMenu() {
    $.post('https://skyline_weaponshop/close', JSON.stringify({}));

    $("#main_container").fadeOut(400);
    timeout = setTimeout(function() {
        $("#main_container").html("");
        $("#main_container").fadeIn();
    }, 400);
}

  
$(document).keyup(function (e) {
    if (e.keyCode === 27) {
  
      closeMenu();
  
    }
  
});
//end


function weaponMenu() {
 
    var base = 
 
    '  <div id="mainGradient"></div>' +
    '  <div id="mainGradient2"></div>' +
    '  <div id="Main">';
 
    if (shoptype == "WeaponShop") {

        base = base +  '  <div class="e5_52 glow-button" onclick="gunMenu()" id="gunimg"><span class="e55_318" onclick="gunMenu()">WAFFEN</span><div id="gradient"></div></div>';
           
        base = base +'  <div class="e7_148 glow-button" onclick="explosiveMenu()" id="explosiveimg"><span class="e55_322" onclick="explosiveMenu()">Bald...</span><div id="gradient"></div></div>';
       
        base = base + '  <div class="e5_53 glow-button" onclick="showLoadout()" id="attachmentimg"><span class="e55_320" onclick="attachmentMenu()">Bald...</span><div id="gradient"></div></div>'+
        '  <div class="e5_55 glow-button" onclick="ammoMenu()" id="ammoimg"><span class="e55_323" onclick="ammoMenu()">MUNITION</span><div id="gradient"></div></div>'+
        '  <div class="e5_56 glow-button" onclick="armorMenu()" id="armorimg"><span class="e55_321" onclick="armorMenu()">WESTEN</span><div id="gradient"></div></div>'+
        '  <div class="e5_57 glow-button" onclick="meleeMenu()" id="meleeimg"><span class="e55_319" onclick="meleeMenu()">NAHKAMPF</span><div id="gradient"></div></div>'+
        '  <span class="e7_168">'+Config.GunShops.WeaponShop.ShopName+'</span>';

    } else if (shoptype == "BlackMarket"){

        base = base +
        '  <div class="e5_52 glow-button" onclick="gunMenu()" id="gunimg"><span class="e55_318" onclick="gunMenu()">GUNS</span><div id="gradient"></div></div>'+
        '  <div class="e7_148 glow-button" onclick="explosiveMenu()" id="explosiveimg"><span class="e55_322" onclick="explosiveMenu()">Kommt bald...</span><div id="gradient"></div></div>'+
        '  <div class="e5_53 glow-button" onclick="showLoadout()" id="attachmentimg"><span class="e55_320" onclick="attachmentMenu()">ATTACHMENTS</span><div id="gradient"></div></div>'+
        '  <div class="e5_55 glow-button" onclick="ammoMenu()" id="ammoimg"><span class="e55_323" onclick="ammoMenu()">AMMO</span><div id="gradient"></div></div>'+
        '  <div class="e5_56 glow-button" onclick="armorMenu()" id="armorimg"><span class="e55_321" onclick="armorMenu()">WESTEN</span><div id="gradient"></div></div>'+
        '  <div class="e5_57 glow-button" onclick="meleeMenu()" id="meleeimg"><span class="e55_319" onclick="meleeMenu()">MELEE</span><div id="gradient"></div></div>'+
        '  <span class="e7_168">'+Config.GunShops.BlackMarket.ShopName+'</span>';

    }
    base = base +
    '  <div class="e5_51 glow-button" onclick="closeMenu()"><span class="e55_324">Zurück</span></div>'+
    '</div>';
 
    $("#main_container").html(base);
 
}


function gunMenu() {

var base = 
'  <div id="mainGradient"></div>' +
'  <div id="mainGradient2"></div>' +
'  <div id="Main">';
       
    if (shoptype == "WeaponShop") {

     
            base = base + '  <div onclick="handgunMenu()" id="handgunimg"><div id="gradient2"></div><span class="e55_318" onclick="handgunMenu()">PISTOLEN</span></div>';
      
      
        
                
    } else if (shoptype == "BlackMarket"){
        base = base + 
        '  <div onclick="handgunMenu()" id="handgunimg"><div id="gradient2"></div><span class="e55_318" onclick="handgunMenu()">PISTOLEN</span></div>'+
        '  <div onclick="rifleMenu()" id="rifleimg"><div id="gradient2"></div><span class="e55_318" onclick="rifleMenu()">RIFLES</span></div>'+
        '  <div onclick="sniperMenu()" id="sniperimg"><div id="gradient2"></div><span class="e55_318" onclick="sniperMenu()">SNIPERS</span></div>'+
        '  <div onclick="smgMenu()" id="smgimg"><div id="gradient2"></div><span class="e55_318" onclick="smgMenu()">SMGs</span></div>'+
        '  <div onclick="lmgMenu()" id="lmgimg"><div id="gradient2"></div><span class="e55_318" onclick="lmgMenu()">LMGs</span></div>'+
        '  <div onclick="shotgunMenu()" id="shotgunimg"><div id="gradient2"></div><span class="e55_318" onclick="shotgunMenu()">SHOTGUNS</span></div>';

    }

        base = base + '<div class="e12_228" onclick="weaponMenu()"><span class="e12_229">Zurück</span><i class="fas fa-chevron-left" id="arrowleft"></i></div>'+
            '<span class="e14_298">WAFFEN</span>'+       
        '</div>';
        
    $("#main_container").html(base);
}	



function handgunMenu() {

var base =
'  <div id="mainGradient"></div>' +
'  <div id="mainGradient2"></div>' + 
'<div id="Guns">'+ 
    '<div id = "page">';

    if (shoptype == "WeaponShop") {

        for (const [key2, value2] of Object.entries(Config.GunShops.WeaponShop)) {

            if (key2 == "pistols") {

                for (const [key3, value3] of Object.entries(value2)) {
    
                    base = base + '<div id="weap" style=" background: url(src/'+key2+'/'+key3+'.png)  no-repeat center center,  linear-gradient(90deg, rgba(3, 236, 252 ,0.9612219887955182) 0%, rgba(3, 116, 255,0.4458158263305322) 100%);" onclick="buyGun(\'' + key3 + '\', \''+ value3.price +'\')"><span id="label">'+value3.label+'</span><span class="e57_7">$'+value3.price+'</span></div>';   

                } 
            }
        }
    } else if (shoptype == "BlackMarket"){
        for (const [key2, value2] of Object.entries(Config.GunShops.BlackMarket)) {

            if (key2 == "pistols") {

                for (const [key3, value3] of Object.entries(value2)) {
    
                    base = base + '<div id="weap" style=" background: url(src/'+key2+'/'+key3+'.png)  no-repeat center center,  linear-gradient(90deg, rgba(64,44,69,0.9612219887955182) 0%, rgba(201,56,222,0.4458158263305322) 100%);" onclick="buyGun(\'' + key3 + '\', \''+ value3.price +'\')"><span id="label">'+value3.label+'</span><span class="e57_7">$'+value3.price+'</span></div>';   

                } 
            }
        }
    } 
    base = base +'</div>'+
    
    '<div class="e12_228" onclick="gunMenu()"><span class="e12_229">Zurück</span><i class="fas fa-chevron-left" id="arrowleft"></i></div>'+
    '<span class="e14_298">PISTOLEN</span>'+
    
'</div>';
	
    $("#main_container").html(base);
}
	

function rifleMenu() {

var base = 
'  <div id="mainGradient"></div>' +
'  <div id="mainGradient2"></div>' +
'<div id="Guns">'+ 
    '<div id = "page">';

    if (shoptype == "WeaponShop") {

        for (const [key2, value2] of Object.entries(Config.GunShops.WeaponShop)) {

            if (key2 == "rifles") {

                for (const [key3, value3] of Object.entries(value2)) {
                    
                    base = base +'<div  id="weap" style="background: url(src/'+key2+'/'+key3+'.png)  no-repeat center center, linear-gradient(90deg, rgba(64,44,69,0.9612219887955182) 0%, rgba(201,56,222,0.4458158263305322) 100%);" onclick="buyGun(\'' + key3 + '\', \''+ value3.price +'\')"><span id="label">'+value3.label+'</span><span class="e57_7">$'+value3.price+'</span></div>';   
                
                } 
            }
        }
    } else if (shoptype == "BlackMarket"){

        for (const [key2, value2] of Object.entries(Config.GunShops.BlackMarket)) {

            if (key2 == "rifles") {

                for (const [key3, value3] of Object.entries(value2)) {
                    
                    base = base +'<div  id="weap" style="background: url(src/'+key2+'/'+key3+'.png)  no-repeat center center, linear-gradient(90deg, rgba(64,44,69,0.9612219887955182) 0%, rgba(201,56,222,0.4458158263305322) 100%);" onclick="buyGun(\'' + key3 + '\', \''+ value3.price +'\')"><span id="label">'+value3.label+'</span><span class="e57_7">$'+value3.price+'</span></div>';   
                
                } 
            }
        }
    }
    base = base +'</div>'+
    
    '<div class="e12_228" onclick="gunMenu()"><span class="e12_229">Zurück</span><i class="fas fa-chevron-left" id="arrowleft"></i></div>'+
    '<span class="e14_298">ASSAULT RIFLES</span>'+
    
'</div>';
	
    $("#main_container").html(base);
}

function sniperMenu() {

var base = 
'  <div id="mainGradient"></div>' +
'  <div id="mainGradient2"></div>' +
'<div id="Guns">'+ 
    '<div id = "page">';

    if (shoptype == "WeaponShop") {

        for (const [key2, value2] of Object.entries(Config.GunShops.WeaponShop)) {

            if (key2 == "snipers") {

                for (const [key3, value3] of Object.entries(value2)) {
                    
                    base = base + '<div  id="weap" style="background: url(src/'+key2+'/'+key3+'.png)  no-repeat center center, linear-gradient(90deg, rgba(64,44,69,0.9612219887955182) 0%, rgba(201,56,222,0.4458158263305322) 100%);" onclick="buyGun(\'' + key3 + '\', \''+ value3.price +'\')"><span id="label">'+value3.label+'</span><span class="e57_7">$'+value3.price+'</span></div>';   
                    

                } 
            }
        }
    } else if (shoptype == "BlackMarket"){

        for (const [key2, value2] of Object.entries(Config.GunShops.BlackMarket)) {

            if (key2 == "snipers") {

                for (const [key3, value3] of Object.entries(value2)) {
                    
                    base = base + '<div  id="weap" style="background: url(src/'+key2+'/'+key3+'.png)  no-repeat center center, linear-gradient(90deg, rgba(64,44,69,0.9612219887955182) 0%, rgba(201,56,222,0.4458158263305322) 100%);" onclick="buyGun(\'' + key3 + '\', \''+ value3.price +'\')"><span id="label">'+value3.label+'</span><span class="e57_7">$'+value3.price+'</span></div>';   
                    

                } 
            }
        }
    }
 
    base = base +'</div>'+
    
    '<div class="e12_228" onclick="gunMenu()"><span class="e12_229">Zurück</span><i class="fas fa-chevron-left" id="arrowleft"></i></div>'+
    '<span class="e14_298">SNIPER RIFLES</span>'+
    
'</div>';
	
    $("#main_container").html(base);
}

function smgMenu() {

var base = 
'  <div id="mainGradient"></div>' +
'  <div id="mainGradient2"></div>' +
'<div id="Guns">'+ 
    '<div id = "page">';

    if (shoptype == "WeaponShop") {

        for (const [key2, value2] of Object.entries(Config.GunShops.WeaponShop)) {

            if (key2 == "smgs") {

                for (const [key3, value3] of Object.entries(value2)) {
                    
                    base = base + '<div  id="weap" style="background: url(src/'+key2+'/'+key3+'.png)  no-repeat center center,  linear-gradient(90deg, rgba(64,44,69,0.9612219887955182) 0%, rgba(201,56,222,0.4458158263305322) 100%);" onclick="buyGun(\'' + key3 + '\', \''+ value3.price +'\')"><span id="label">'+value3.label+'</span><span class="e57_7">$'+value3.price+'</span></div>';   

                } 
            }
        }
    } else if (shoptype == "BlackMarket"){

        for (const [key2, value2] of Object.entries(Config.GunShops.BlackMarket)) {

            if (key2 == "smgs") {

                for (const [key3, value3] of Object.entries(value2)) {
                    
                    base = base + '<div  id="weap" style="background: url(src/'+key2+'/'+key3+'.png)  no-repeat center center,  linear-gradient(90deg, rgba(64,44,69,0.9612219887955182) 0%, rgba(201,56,222,0.4458158263305322) 100%);" onclick="buyGun(\'' + key3 + '\', \''+ value3.price +'\')"><span id="label">'+value3.label+'</span><span class="e57_7">$'+value3.price+'</span></div>';   

                } 
            }
        }
    }

 
    base = base +'</div>'+
    
    '<div class="e12_228" onclick="gunMenu()"><span class="e12_229">Zurück</span><i class="fas fa-chevron-left" id="arrowleft"></i></div>'+
    '<span class="e14_298">SUBMACHINE GUNS</span>'+
    
'</div>';
	
    $("#main_container").html(base);
}

function lmgMenu() {

var base = 
'  <div id="mainGradient"></div>' +
'  <div id="mainGradient2"></div>' +
'<div id="Guns">'+ 
    '<div id = "page">';

    if (shoptype == "WeaponShop") {

        for (const [key2, value2] of Object.entries(Config.GunShops.WeaponShop)) {

            if (key2 == "lmgs") {

                for (const [key3, value3] of Object.entries(value2)) {

                    base = base + '<div  id="weap" style="background: url(src/'+key2+'/'+key3+'.png)  no-repeat center center,  linear-gradient(90deg, rgba(64,44,69,0.9612219887955182) 0%, rgba(201,56,222,0.4458158263305322) 100%); " onclick="buyGun(\'' + key3 + '\', \''+ value3.price +'\')"><span id="label">'+value3.label+'</span><span class="e57_7">$'+value3.price+'</span></div>';   

                } 
            }
        }
    } else if (shoptype == "BlackMarket"){

        for (const [key2, value2] of Object.entries(Config.GunShops.BlackMarket)) {

            if (key2 == "lmgs") {

                for (const [key3, value3] of Object.entries(value2)) {

                    base = base + '<div  id="weap" style="background: url(src/'+key2+'/'+key3+'.png)  no-repeat center center,  linear-gradient(90deg, rgba(64,44,69,0.9612219887955182) 0%, rgba(201,56,222,0.4458158263305322) 100%); " onclick="buyGun(\'' + key3 + '\', \''+ value3.price +'\')"><span id="label">'+value3.label+'</span><span class="e57_7">$'+value3.price+'</span></div>';   

                } 
            }
        }
    }
 
    base = base +'</div>'+
    
    '<div class="e12_228" onclick="gunMenu()"><span class="e12_229">Zurück</span><i class="fas fa-chevron-left" id="arrowleft"></i></div>'+
    '<span class="e14_298">LIGHT MACHINE GUNS</span>'+
    
'</div>';
	
    $("#main_container").html(base);
}

function shotgunMenu() {

var base = 
'  <div id="mainGradient"></div>' +
'  <div id="mainGradient2"></div>' +
'<div id="Guns">'+ 
    '<div id = "page">';

    if (shoptype == "WeaponShop") {

        for (const [key2, value2] of Object.entries(Config.GunShops.WeaponShop)) {

            if (key2 == "shotguns") {

                for (const [key3, value3] of Object.entries(value2)) {
                    
                    base = base + '<div id="weap" style="background: url(src/'+key2+'/'+key3+'.png)  no-repeat center center,  linear-gradient(90deg, rgba(64,44,69,0.9612219887955182) 0%, rgba(201,56,222,0.4458158263305322) 100%);" onclick="buyGun(\'' + key3 + '\', \''+ value3.price +'\')"><span id="label">'+value3.label+'</span><span class="e57_7">$'+value3.price+'</span></div>';   

                } 
            }
        }
    } else if (shoptype == "BlackMarket"){
        
        for (const [key2, value2] of Object.entries(Config.GunShops.BlackMarket)) {

            if (key2 == "shotguns") {

                for (const [key3, value3] of Object.entries(value2)) {
                    
                    base = base + '<div id="weap" style="background: url(src/'+key2+'/'+key3+'.png)  no-repeat center center,  linear-gradient(90deg, rgba(64,44,69,0.9612219887955182) 0%, rgba(201,56,222,0.4458158263305322) 100%);" onclick="buyGun(\'' + key3 + '\', \''+ value3.price +'\')"><span id="label">'+value3.label+'</span><span class="e57_7">$'+value3.price+'</span></div>';   

                } 
            }
        }
    }
 
    base = base +'</div>'+
    
    '<div class="e12_228" onclick="gunMenu()"><span class="e12_229">Zurück</span><i class="fas fa-chevron-left" id="arrowleft"></i></div>'+
    '<span class="e14_298">SHOTGUNS</span>'+
    
'</div>';
	
    $("#main_container").html(base);
}

function buyGun(gun, money) {

    $.post('https://skyline_weaponshop/buyGun', JSON.stringify({gun: gun, money: money}));

}








function ammoMenu() {

var base = 
'  <div id="mainGradient"></div>' +
'  <div id="mainGradient2"></div>' +
'<div id="Ammo">'+
    '<div class="e7_227">';

    
    if (shoptype == "WeaponShop") {

        for (const [key2, value2] of Object.entries(Config.GunShops.WeaponShop)) {

            if (key2 == "ammo") {

                for (const [key3, value3] of Object.entries(value2)) {
                
                    base = base + '<div class="e12_231" style="background: url(src/'+key2+'/'+key3+'.png)  no-repeat center center,  linear-gradient(90deg, rgba(3, 230, 255,0.9612219887955182) 0%, rgba(3, 83, 255,0.4458158263305322) 100%); "onclick="buyAmmo(\'' + key3 + '\', \''+ value3.price +'\', \''+ value3.amount +'\')"><span class="e12_236">'+value3.label+'</span><span class="e12_241">'+value3.amount+'</span><span class="e57_7" id="price">$'+value3.price+'</span></div>';   
    
                }      
            } 
        }
    } else if (shoptype == "BlackMarket"){

        for (const [key2, value2] of Object.entries(Config.GunShops.BlackMarket)) {

            if (key2 == "ammo") {

                for (const [key3, value3] of Object.entries(value2)) {
                
                    base = base + '<div class="e12_231" style="background: url(src/'+key2+'/'+key3+'.png)  no-repeat center center,  linear-gradient(90deg, rgba(64,44,69,0.9612219887955182) 0%, rgba(201,56,222,0.4458158263305322) 100%); "onclick="buyAmmo(\'' + key3 + '\', \''+ value3.price +'\', \''+ value3.amount +'\')"><span class="e12_236">'+value3.label+'</span><span class="e12_241">'+value3.amount+'</span><span class="e57_7" id="price">$'+value3.price+'</span></div>';   
    
                }      
            } 
        }
    }

    base = base +'</div>'+


    '<span class="e12_240"> MUNITION</span>'+
    '<div class="e12_228" onclick="weaponMenu()"><span class="e12_229">Zurück</span><i class="fas fa-chevron-left" id="arrowleft"></i></div>'+


'</div>';

    $("#main_container").html(base);
}		
function buyAmmo(ammo, money, amount) {

    $.post('https://skyline_weaponshop/buyAmmo', JSON.stringify({ammo: ammo, money: money, amount: amount}));

}




function explosiveMenu() {

var base = 
'  <div id="mainGradient"></div>' +
'  <div id="mainGradient2"></div>' +
'<div id="explosives">'+  
    '<div class=e4_291>';

    if (shoptype == "WeaponShop") {

        for (const [key2, value2] of Object.entries(Config.GunShops.WeaponShop)) {

            if (key2 == "explosives") {

                for (const [key3, value3] of Object.entries(value2)) {
                
                    base = base + '<div class="e14_295" style=" background: url(src/'+key2+'/'+key3+'.png)  no-repeat center center,  linear-gradient(90deg, rgba(64,44,69,0.9612219887955182) 0%, rgba(201,56,222,0.4458158263305322) 100%);" onclick="buyExplosive(\'' + key3 + '\', \''+ value3.price +'\')"><span class="e14_303">'+value3.label+'</span><span class="e57_7">$'+value3.price+'</span></div>';   
    
                }      
            } 
        }
    } else if (shoptype == "BlackMarket"){

        for (const [key2, value2] of Object.entries(Config.GunShops.BlackMarket)) {

            if (key2 == "explosives") {

                for (const [key3, value3] of Object.entries(value2)) {
                
                    base = base + '<div class="e14_295" style=" background: url(src/'+key2+'/'+key3+'.png)  no-repeat center center,  linear-gradient(90deg, rgba(64,44,69,0.9612219887955182) 0%, rgba(201,56,222,0.4458158263305322) 100%);" onclick="buyExplosive(\'' + key3 + '\', \''+ value3.price +'\')"><span class="e14_303">'+value3.label+'</span><span class="e57_7">$'+value3.price+'</span></div>';   
    
                }      
            } 
        }
    }
    base = base +'</div>'+
    '<span class="e14_298">Bald...</span>'+
    '<div class="e12_228"  onclick="weaponMenu()"><span class="e12_229">Zurück</span><i class="fas fa-chevron-left" id="arrowleft"></i></div>'+
    
    '</div>';

    $("#main_container").html(base);
}

function buyExplosive(explosive, money) {

    $.post('https://skyline_weaponshop/buyExplosive', JSON.stringify({explosive: explosive, money: money}));

}


function armorMenu() {

var base =
'  <div id="mainGradient"></div>' +
'  <div id="mainGradient2"></div>' +
'<div id="armor">'+ 
    '<div class=e12_271>';
    
 
    if (shoptype == "WeaponShop") {
        base = base +
        '<div class="e12_277" id="light" onclick="Light(\''+Config.GunShops.WeaponShop['armor']['20'].percentage+'\', \''+Config.GunShops.WeaponShop['armor']['20'].price+'\')"><span class="e12_282">'+Config.GunShops.WeaponShop['armor']['20'].label+'</span><span class="e12_286">'+Config.GunShops.WeaponShop['armor']['20'].percentage+'%</span><span class="e68_31">$'+Config.GunShops.WeaponShop['armor']['20'].price+'</span></div>'+
        '<div class="e12_279" id="standard" onclick="Standard(\''+Config.GunShops.WeaponShop['armor']['50'].percentage+'\', \''+Config.GunShops.WeaponShop['armor']['50'].price+'\')"><span class="e12_283">'+Config.GunShops.WeaponShop['armor']['50'].label+'</span><span class="e12_286">'+Config.GunShops.WeaponShop['armor']['50'].percentage+'%</span><span class="e68_31">$'+Config.GunShops.WeaponShop['armor']['50'].price+'</span></div>'+
        '<div class="e12_278" id="superheavy" onclick="superHeavy(\''+Config.GunShops.WeaponShop['armor']['100'].percentage+'\', \''+Config.GunShops.WeaponShop['armor']['100'].price+'\')"><span class="e12_281">'+Config.GunShops.WeaponShop['armor']['100'].label+'</span><span class="e12_286">'+Config.GunShops.WeaponShop['armor']['100'].percentage+'%</span><span class="e68_31">$'+Config.GunShops.WeaponShop['armor']['100'].price+'</span></div>';
    
    } else if (shoptype == "BlackMarket"){
        base = base +
        '<div class="e12_276" id="superlight" onclick="superLight(\''+Config.GunShops.BlackMarket['armor']['15'].percentage+'\', \''+Config.GunShops.BlackMarket['armor']['15'].price+'\')"><span class="e12_280">'+Config.GunShops.BlackMarket['armor']['15'].label+'</span><span class="e12_286">'+Config.GunShops.BlackMarket['armor']['15'].percentage+'%</span><span class="e67_27">$'+Config.GunShops.BlackMarket['armor']['15'].price+'</span></div>'+
        '<div class="e12_277" id="light" onclick="Light(\''+Config.GunShops.BlackMarket['armor']['40'].percentage+'\', \''+Config.GunShops.BlackMarket['armor']['40'].price+'\')"><span class="e12_282">'+Config.GunShops.BlackMarket['armor']['40'].label+'</span><span class="e12_286">'+Config.GunShops.BlackMarket['armor']['40'].percentage+'%</span><span class="e68_31">$'+Config.GunShops.BlackMarket['armor']['40'].price+'</span></div>'+
        '<div class="e12_279" id="standard" onclick="Standard(\''+Config.GunShops.BlackMarket['armor']['60'].percentage+'\', \''+Config.GunShops.BlackMarket['armor']['60'].price+'\')"><span class="e12_283">'+Config.GunShops.BlackMarket['armor']['60'].label+'</span><span class="e12_286">'+Config.GunShops.BlackMarket['armor']['60'].percentage+'%</span><span class="e68_31">$'+Config.GunShops.BlackMarket['armor']['60'].price+'</span></div>'+
        '<div class="e12_275" id="heavy" onclick="Heavy(\''+Config.GunShops.BlackMarket['armor']['80'].percentage+'\', \''+Config.GunShops.BlackMarket['armor']['80'].price+'\')"><span class="e12_284">'+Config.GunShops.BlackMarket['armor']['80'].label+'</span><span class="e12_286">'+Config.GunShops.BlackMarket['armor']['80'].percentage+'%</span><span class="e68_31">$'+Config.GunShops.BlackMarket['armor']['80'].price+'</span></div>'+
        '<div class="e12_278" id="superheavy" onclick="superHeavy(\''+Config.GunShops.BlackMarket['armor']['100'].percentage+'\', \''+Config.GunShops.BlackMarket['armor']['100'].price+'\')"><span class="e12_281">'+Config.GunShops.BlackMarket['armor']['100'].label+'</span><span class="e12_286">'+Config.GunShops.BlackMarket['armor']['100'].percentage+'%</span><span class="e68_31">$'+Config.GunShops.BlackMarket['armor']['100'].price+'</span></div>';
    }
        base = base +'</div>'+

    '<span class="e12_285">WESTEN</span>'+
    '<div class="e12_228" onclick="weaponMenu()"><span class="e12_229">Zurück</span><i class="fas fa-chevron-left" id="arrowleft"></i></div>'+
    '</div>';

    $("#main_container").html(base);
}

function superLight(superlight, money) {

    $.post('https://skyline_weaponshop/superLight', JSON.stringify({superlight: superlight, money: money}));

}
function Light(light, money) {

    $.post('https://skyline_weaponshop/Light', JSON.stringify({light: light, money: money}));

}
function Standard(standard, money) {

    $.post('https://skyline_weaponshop/Standard', JSON.stringify({standard: standard, money: money}));

}
function Heavy(heavy, money) {

    $.post('https://skyline_weaponshop/Heavy', JSON.stringify({heavy: heavy, money: money}));

}
function superHeavy(superheavy, money) {

    $.post('https://skyline_weaponshop/superHeavy', JSON.stringify({superheavy: superheavy, money: money}));

}





function showLoadout() {

    var blacklist = ["weapon_knife", "weapon_bat", "weapon_bottle", "weapon_crowbar", "weapon_flashlight", "weapon_golfclub", "weapon_hammer", "weapon_hatchet", "weapon_knuckle", "weapon_machete",
    "weapon_switchblade", "weapon_nightstick", "weapon_wrench", "weapon_battleaxe", "weapon_poolcue", "weapon_stone_hatchet", "weapon_grenade", "weapon_bzgas", "weapon_molotov", "weapon_stickybomb",
    "weapon_proxmine", "weapon_snowball", "weapon_stungun", "weapon_pipebomb", "weapon_ball", "weapon_smokegrenade", "weapon_flare", "weapon_petrolcan", "gadget_parachute", "weapon_fireextinguisher", "weapon_hazardcan"];

    var base = 
    '  <div id="mainGradient"></div>' +
    '  <div id="mainGradient2"></div>' +
    '<div id="attachment">'+ 
    '<div class=e4_291>';

    for (const [key2, value2] of Object.entries(loadout)) {
        if (blacklist.includes(value2.name) == false) { 

            //base = base + '<div class="e14_295" style="background: url(src/loadout/'+value2.name+'.png)  no-repeat center center, linear-gradient(90deg, rgba(64,44,69,0.9612219887955182) 0%, rgba(201,56,222,0.4458158263305322) 100%);" onclick="attachmentMenu(\''+value2.name+'\')"><span class="e14_303">'+value2.label.toUpperCase()+'</span></div>';   
        }
    }
  

    base = base + '</div>'+

    '<div class="e12_228" onclick="weaponMenu()"><span class="e12_229">Zurück</span><i class="fas fa-chevron-left" id="arrowleft"></i></div>'+
    '<span class="e14_298">Bald...</span>'+
    '</div>';
	
    $("#main_container").html(base);
}




function attachmentMenu(weapon) {

    var base = 
    '  <div id="mainGradient"></div>' +
    '  <div id="mainGradient2"></div>' +
    '<div id="attachment">'+ 
    '<div class=e4_291>';
      
    if (shoptype == "WeaponShop") {

        for (const [key2, value2] of Object.entries(Config.GunShops.WeaponShop)) {
        
            if (key2 == "attachments") {
        
                for (const [key3, value3] of Object.entries(value2)) {
                
                    base = base + '<div class="e14_295" style="background: url(src/'+key2+'/'+value3.label+'.png)  no-repeat center center,  linear-gradient(90deg, rgba(64,44,69,0.9612219887955182) 0%, rgba(201,56,222,0.4458158263305322) 100%);" onclick="buyAttach(\''+key3+'\', \''+weapon+'\', \''+value3.price+'\')"><span class="e14_303">'+value3.label+'</span><span class="e57_7">$'+value3.price+'</span></div>';   
        

                }      
            } 
        }

    } else if (shoptype == "BlackMarket"){

        for (const [key2, value2] of Object.entries(Config.GunShops.BlackMarket)) {
        
            if (key2 == "attachments") {
        
                for (const [key3, value3] of Object.entries(value2)) {
                
                    base = base + '<div class="e14_295" style="background: url(src/'+key2+'/'+value3.label+'.png)  no-repeat center center,  linear-gradient(90deg, rgba(64,44,69,0.9612219887955182) 0%, rgba(201,56,222,0.4458158263305322) 100%);" onclick="buyAttach(\''+key3+'\', \''+weapon+'\', \''+value3.price+'\')"><span class="e14_303">'+value3.label+'</span><span class="e57_7">$'+value3.price+'</span></div>';   
        

                }      
            } 
        }
    }        

    base = base + '</div>'+
    
    '<div class="e12_228" onclick="showLoadout()"><span class="e12_229">Zurück</span><i class="fas fa-chevron-left" id="arrowleft"></i></div>'+
    '<span class="e14_298">Bald...</span>'+
    '</div>';
        
    $("#main_container").html(base);
    
    
}


function buyAttach(attach, weapon, money) {

    $.post('https://skyline_weaponshop/buyAttach', JSON.stringify({attach: attach, weapon: weapon, money: money}));

}





function meleeMenu() {

    var base =
    '  <div id="mainGradient"></div>' +
    '  <div id="mainGradient2"></div>' +
    '<div id="melee">'+ 
    '<div class=e4_291>';

    if (shoptype == "WeaponShop") {

        for (const [key2, value2] of Object.entries(Config.GunShops.WeaponShop)) {

            if (key2 == "melee") {

                for (const [key3, value3] of Object.entries(value2)) {
            
                    base = base + '<div class="e14_295" style="background: url(src/'+key2+'/'+key3+'.png)  no-repeat center center,  linear-gradient(90deg, rgba(66, 135, 245,0.9612219887955182) 0%, rgba(66, 230, 245,0.4458158263305322) 100%);" onclick="buyMelee(\'' + key3 + '\', \''+ value3.price +'\')"><span class="e14_303">'+value3.label+'</span><span class="e57_7">$'+value3.price+'</span></div>';   
                        
                }
            }      
        } 
    } else if (shoptype == "BlackMarket"){

        for (const [key2, value2] of Object.entries(Config.GunShops.BlackMarket)) {

            if (key2 == "melee") {

                for (const [key3, value3] of Object.entries(value2)) {
            
                    base = base + '<div class="e14_295" style="background: url(src/'+key2+'/'+key3+'.png)  no-repeat center center,  linear-gradient(90deg, rgba(64,44,69,0.9612219887955182) 0%, rgba(201,56,222,0.4458158263305322) 100%);" onclick="buyMelee(\'' + key3 + '\', \''+ value3.price +'\')"><span class="e14_303">'+value3.label+'</span><span class="e57_7">$'+value3.price+'</span></div>';   
                        
                }
            }      
        } 
    }
    base = base + '</div>'+
    '<div class="e12_228" onclick="weaponMenu()"><span class="e12_229">Zurück</span><i class="fas fa-chevron-left" id="arrowleft"></i></div>'+
    '<span class="e14_298">NAHKAMPF</span>'+
    '</div>';

    $("#main_container").html(base);
}


function buyMelee(melee, money) {

    $.post('https://skyline_weaponshop/buyMelee', JSON.stringify({melee: melee, money: money}));

}



function licenseMenu() {

    var base = 
    '  <div id="mainGradient"></div>' +
    '  <div id="mainGradient2"></div>' +
    '<div id="licensepage">'+
    '<div id="licenses">';

    for (const [key2, value2] of Object.entries(Config.licenses)) {

        base = base + '<div id="pistollicense" style =" background: url(src/'+key2+'.png)  no-repeat center center,  linear-gradient(90deg, rgba(64,44,69,0.9612219887955182) 0%, rgba(201,56,222,0.4458158263305322) 100%);" onclick="buyLicense(\''+key2+'\', \''+value2.price+'\')"><span id="licenselabel">'+value2.label+'</span><span id="licenseprice">$'+value2.price+'</span></div>';

    }
    base = base + '</div>'+

    '<span class="e12_285">LICENSES</span>'+
    '<div id="Zurück" onclick="weaponMenu()"><span class="e12_229">Zurück</span><i class="fas fa-chevron-left" id="arrowleft"></i></div>';
  
    '</div>'


    $("#main_container").html(base);

}

function buyLicense(license, money) {

    $.post('https://skyline_weaponshop/buyLicense', JSON.stringify({license: license, money: money}));


}




window.addEventListener('message', function (event) {


    var edata = event.data;

    if (edata.type == 'show') {
        
        loadout = edata.loadout;
        Config = edata.config;
        Licenses = edata.licenses;
        shoptype = edata.shoptype;
        weaponMenu();
        
    }

    if (edata.type == 'hide') {

        $('#main_container').fadeOut();
        setTimeout(function() {
            $('#main_container').html("");
            $("#main_container").fadeIn();
        }, 400)
    }
});