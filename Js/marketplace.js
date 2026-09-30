/* Shared storefront behaviour: consumes existing menu, address and cart controls. */
(function () {
'use strict';
var categories = [
    ['Grocery', 'basket2', '../Front/Search.aspx?SubSubCategory=3', 'essentials'], ['Saloon', 'scissors', '../Front/Appointment1.aspx','services'],
    ['Ladies Accessories', 'handbag', '../Front/Search.aspx?SubSubCategory=7', ''], ['Home Decor', 'house-heart', '../Front/Search.aspx?SubSubCategory=10010', 'local'],['Jobs','briefcase','../Pages/Registration.aspx',''],
    ['Home Services', 'tools', '../Pages/Job.aspx', 'services'], ['Skilled Services', 'person-gear', '../Pages/Job.aspx', 'services'], ['Desi Products', 'flower1', '../Front/Search.aspx?SubSubCategory=10005','local'],
    ['Home Essentials', 'house', '../Front/Search.aspx?SubSubCategory=10012', 'essentials'],
    ['Daily Expenses', 'wallet2', '../Pages/ExpenseManager.aspx', '']
];
function destination(item) { return item[2].indexOf('.aspx') >= 0 ? item[2] : 'Search.aspx?Search=' + encodeURIComponent(item[2]); }
function makeLink(item, compact) {
 var a=document.createElement('a'); a.href=destination(item); a.className=compact?'mn-quick'+(item[3]==='services'?' mn-service-card':''):'mn-category';
 var icon=document.createElement(compact?'i':'span'); icon.className=compact?'bi bi-'+item[1]:'mn-category-icon'; icon.setAttribute('aria-hidden','true');
 if(!compact){var glyph=document.createElement('i');glyph.className='bi bi-'+item[1];icon.appendChild(glyph);} a.appendChild(icon);
 var text=document.createElement(compact?'div':'span');if(compact){var title=document.createElement('strong');title.textContent=item[0];text.appendChild(title);var caption=document.createElement('small');caption.textContent=item[0]==='Saloon'?'Book an appointment →':item[3]==='services'?'Find professionals →':'Explore collection →';text.appendChild(caption);}else{text.textContent=item[0];}a.appendChild(text);
 if(item[0]==='Saloon')a.addEventListener('click',function(e){var user=document.querySelector('[id$=MasterhdnUserId]');if(!user || !user.value || user.value==='0'){e.preventDefault();window.OpenLogin();}});
 return a;
}
function init(){
    //var grid = document.getElementById('mn-category-grid');
    //if (grid) categories.forEach(function (c) { grid.appendChild(makeLink(c, false)); });

    var grid = document.getElementById('mn-category-grid');

    if (grid) {
        categories
            .filter(function (c) {
                return c[3] !== 'essentials';
            })
            .forEach(function (c) {
                grid.appendChild(makeLink(c, false));
            });
    }

 document.querySelectorAll('[data-mn-group]').forEach(function(row){categories.filter(function(c){return c[3]===row.dataset.mnGroup;}).forEach(function(c){row.appendChild(makeLink(c,true));});});
 var drawer=document.getElementById('mainNav'),backdrop=document.getElementById('mn-drawer-backdrop'),lastFocus;
 if(drawer && backdrop){
 drawer.parentElement.appendChild(backdrop);
 var previousOverflow='', inertElements=[];
 function setBackgroundInert(value){
  if(value){var ancestor=drawer;while(ancestor.parentElement && ancestor!==document.body){Array.prototype.forEach.call(ancestor.parentElement.children,function(el){if(el!==ancestor && el!==backdrop && !el.inert && !/^(SCRIPT|STYLE|LINK)$/.test(el.tagName)){el.inert=true;inertElements.push(el);}});ancestor=ancestor.parentElement;}}
  else {inertElements.forEach(function(el){el.inert=false;});inertElements=[];}
 }
 var drawerClose=drawer.querySelector('.mobile-menu-heading button');if(drawerClose)drawerClose.removeAttribute('data-mn-drawer');
 var menu=drawer.querySelector('.mobile-menu-categories');
 if(menu) categories.forEach(function(c){ var exists=Array.prototype.some.call(menu.querySelectorAll('a'),function(a){return a.textContent.trim().toLowerCase().indexOf(c[0].toLowerCase())>=0;}); if(!exists){var link=makeLink(c,true);link.classList.remove('mn-service-card');menu.appendChild(link);} });
 drawer.querySelectorAll('.dropdown-menu').forEach(function(sub,i){
 var trigger=sub.parentElement.querySelector('a');if(!trigger)return;sub.id='mn-subcategory-'+i;
 trigger.removeAttribute('data-toggle');trigger.removeAttribute('data-bs-toggle');trigger.setAttribute('aria-controls',sub.id);trigger.setAttribute('aria-expanded','false');
 trigger.addEventListener('click',function(e){if(window.innerWidth>=992)return;e.preventDefault();e.stopPropagation();var open=trigger.getAttribute('aria-expanded')!=='true';trigger.setAttribute('aria-expanded',String(open));sub.style.setProperty('display',open?'block':'none','important');});
 });
 function close(){drawer.classList.remove('show','in');backdrop.hidden=true;document.body.style.overflow=previousOverflow;document.body.classList.remove('mn-drawer-open');setBackgroundInert(false);drawer.removeAttribute('aria-modal');drawer.removeAttribute('role');document.querySelectorAll('[data-mn-drawer]').forEach(function(b){b.setAttribute('aria-expanded','false');});if(lastFocus)lastFocus.focus();}
 window.mnCloseDrawer=function(){if(!backdrop.hidden)close();};
 function open(button){lastFocus=button;previousOverflow=document.body.style.overflow;drawer.classList.add('show');backdrop.hidden=false;document.body.classList.add('mn-drawer-open');setBackgroundInert(true);document.body.style.overflow='hidden';drawer.setAttribute('role','dialog');drawer.setAttribute('aria-modal','true');drawer.setAttribute('aria-label','Browse categories');document.querySelectorAll('[data-mn-drawer]').forEach(function(b){b.setAttribute('aria-expanded','true');});var firstButton=drawer.querySelector('button');if(firstButton)firstButton.focus();}
 document.querySelectorAll('[data-mn-drawer]').forEach(function(b){b.setAttribute('aria-controls','mainNav');b.setAttribute('aria-expanded','false');b.addEventListener('click',function(){if(window.innerWidth>=992){var target=document.querySelector('[id$=divmenu]');if(target){target.scrollIntoView({block:'nearest'});var first=target.querySelector('a');if(first)first.focus();}}else open(b);});});
 var closeButton=drawer.querySelector('.mobile-menu-heading button');if(closeButton){closeButton.removeAttribute('data-bs-toggle');closeButton.removeAttribute('data-bs-target');closeButton.addEventListener('click',close);}backdrop.addEventListener('click',close);
 drawer.addEventListener('keydown',function(e){if(e.key==='Escape'){e.preventDefault();close();}if(e.key==='Tab'){var focusable=Array.prototype.filter.call(drawer.querySelectorAll('a[href],button,input,[tabindex="0"]'),function(el){return el.getClientRects().length;});if(!focusable.length)return;var first=focusable[0],last=focusable[focusable.length-1];if(e.shiftKey&&document.activeElement===first){e.preventDefault();last.focus();}else if(!e.shiftKey&&document.activeElement===last){e.preventDefault();first.focus();}}});
 drawer.addEventListener('click',function(e){if(e.target.closest('[data-toggle="modal"], [data-bs-toggle="modal"], [onclick*="OpenLogin"]'))window.mnCloseDrawer();},true);
 window.addEventListener('resize',function(){if(window.innerWidth>=992 && !backdrop.hidden)close();});
 }
 var addressLabel=document.getElementById('mn-address-label');
 function updateAddress(){var selected=document.querySelector('[id$=divUserAddresses] .location-box.active');if(addressLabel&&selected){var name=selected.querySelector('.location-name');addressLabel.textContent=name?name.textContent.trim():'Selected address';addressLabel.title=selected.textContent.trim();}}
 updateAddress();var addresses=document.querySelector('[id$=divUserAddresses]');if(addresses){new MutationObserver(updateAddress).observe(addresses,{childList:true,subtree:true,attributes:true,attributeFilter:['class']});addresses.addEventListener('click',function(e){if(e.target.closest('.edit-address-link'))return;var selected=e.target.closest('.location-box');if(selected){addresses.querySelectorAll('.location-box').forEach(function(a){a.classList.toggle('active',a===selected);});updateAddress();}});}
 var bar=document.querySelector('.mn-bottom'),lastY=window.scrollY,scheduled=false;
 if(bar){var current=location.pathname.toLowerCase();bar.querySelectorAll('a').forEach(function(a){if(new URL(a.href).pathname.toLowerCase()===current)a.setAttribute('aria-current','page');});window.addEventListener('scroll',function(){if(scheduled)return;scheduled=true;requestAnimationFrame(function(){var y=Math.max(0,window.scrollY),delta=y-lastY;if(Math.abs(delta)>7){bar.classList.toggle('mn-hidden',y>100&&delta>0&&!bar.contains(document.activeElement));lastY=y;}if(y<40)bar.classList.remove('mn-hidden');scheduled=false;});},{passive:true});bar.addEventListener('focusin',function(){bar.classList.remove('mn-hidden');});}
}
window.mnSearch=function(inputId){var input=document.getElementById(inputId);if(input&&input.value.trim())location.href=window.appURL+'Front/Search.aspx?Search='+encodeURIComponent(input.value.trim());};
window.mnAccount=function(){var user=document.querySelector('[id$=MasterhdnUserId]');if(user&&user.value&&user.value!=='0')location.href=window.appURL+'Front/MyAccount.aspx';else window.OpenLogin();};
if(document.readyState==='loading')document.addEventListener('DOMContentLoaded',init);else init();
})();