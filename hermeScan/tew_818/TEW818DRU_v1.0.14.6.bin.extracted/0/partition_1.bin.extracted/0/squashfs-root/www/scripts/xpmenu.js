/************************************************************************ 
Author: Eric Simmons
Contact: info AT jswitch DOT com
Website: http://www.jswitch.com
Version: 2.4 03/2007       
Browser Target: Mozilla 6+/FireFox Netscape 6+, IE 5.0+
Type: XP Style Menus ver 2.4

DISCLAIMER:
THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT
ANY EXPRESS OR IMPLIED WARRANTIES, JSWITCH.COM
IS NOT RESPONSIBLE FOR ANY ADVERSE AFFECTS TO
YOUR COMPUTER OR SYSTEMS RUNNING THIS SCRIPT.

LICENSE:
YOU ARE GRANTED THE RIGHT TO USE THE SCRIPT
PERSONALLY OR COMMERCIALLY. THE AUTHOR, WEBSITE LINKS 
AND LICENSE INFORMATION IN THE HEADER OF THIS SCRIPT
MUST NOT BE MODIFIED OR REMOVED. IF PORTIONS OF THE 
CODE ARE TRANSFERED TO ANOTHER SCRIT THE AUTHORS NAME
AND CONTACT INFORMATION MUST BE STATED IN THE NEW SCRIPT
BY THE PORTIONS CODE THAT HAVE BEEN TRANSFERED.

***********************************************************************/



var menuObjArray = new Array();
menuObjArray[0] = new Array();
menuObjArray[1] = new Array();
menuObjArray[2] = new Array();
menuObjArray[3] = new Array();
menuObjArray[4] = new Array();
menuObjArray[5] = new Array();
menuObjArray[6] = new Array();
menuObjArray[7] = new Array();


var divovername = "topItem";
var timerSlide = null;
var numMenuItem = 0;
var slideDelay = 1000;
var divHeight = 21; 
var moveSlidePix = 0;
var isLocked = null;
var doFading = true;  
var autoClose = false; 
var dispMenuOnStart = false;                                    


 InitAll();
 
function InitAll()
{
	var divs = document.getElementsByTagName("DIV");


       
	aryNum = 0;
	for(dn=0; dn < divs.length;dn++)
	{
		if(String(divs.item(dn).className).substring(0,7) == "topItem")
		{	
			mainMenuDiv = divs.item(dn).parentNode;
			menuContainerDiv= mainMenuDiv.getElementsByTagName("DIV").item(1);
			itemContainerDiv= menuContainerDiv.getElementsByTagName("DIV").item(0);
			if(dispMenuOnStart)
				itemContainerDiv.style.display = 'inline';
			Init(divs.item(dn));
			aryNum++;
		}
	}	
}




function Init(objDiv)
{
    
    if (isLocked)
        return;

    var mainMenuDiv, subMenuDiv, menuContainerDiv, itemContainerDiv,styleRules;

	
	for(r=0;r < document.styleSheets.length; r++)
	{	
		if( -1 != String(document.styleSheets[r].href).indexOf("style.css") )	
			break;
	}
	if(!document.styleSheets[r].rules)
		styleRules = document.styleSheets[r].cssRules;
	else
		styleRules = document.styleSheets[r].rules;
		
    numMenuItem = 0;
    mainMenuDiv = objDiv.parentNode;
    subMenuDiv =  mainMenuDiv.getElementsByTagName("DIV").item(0);
    

    menuContainerDiv= mainMenuDiv.getElementsByTagName("DIV").item(1);
    itemContainerDiv= menuContainerDiv.getElementsByTagName("DIV").item(0);
    

    aLen = menuObjArray[0].length;
    for (i=0 ;i < aLen ; i++)
    {
        if (menuObjArray[0][i] == menuContainerDiv)
        {
            break;
        }
    }
    
    if (i == aLen)
    {
        menuObjArray[0][i]  = menuContainerDiv;
        menuObjArray[1][i] = itemContainerDiv;
        menuObjArray[7][i] = subMenuDiv;
        menuObjArray[7][i].onmouseover = ChangeStyle;
        menuObjArray[7][i].onmouseout = ChangeStyle;
		
        

        
		lastmenuNum = -1;
        for (b=0;b<itemContainerDiv.childNodes.length;b++)
        {
            if (itemContainerDiv.childNodes.item(b).tagName == "DIV")
            { 
                numMenuItem ++;
                itemContainerDiv.childNodes.item(b).onmouseover= ChangeStyle;
                itemContainerDiv.childNodes.item(b).onmouseout= ChangeStyle;
                lastmenuNum = b;
            }
        }  
        
        
		for(r=0;r < styleRules.length; r++)
		{
			tmpStr1 = String(styleRules[r].selectorText);
			tmpStr2 = String("." + itemContainerDiv.childNodes.item(lastmenuNum).className);
			if(tmpStr1 == tmpStr2)
			{
				if(NaN != parseInt(styleRules[r].style.height))
				{
					divHeight = parseInt(styleRules[r].style.height) + 2;
					break;
				}
				
			}
		}
				
        menuObjArray[2][i] = numMenuItem;
        menuObjArray[3][i] = mainMenuDiv;

        if (itemContainerDiv.style.display == "inline")
        {
            menuObjArray[4][i] = numMenuItem * divHeight;
            menuObjArray[0][i].style.height = numMenuItem * divHeight + "px";
            menuObjArray[6][i] = true;
			
            if(doFading)
			{
				if (menuObjArray[0][i].filters)
					menuObjArray[0][i].filters.alpha.opacity = 100;
				else
					menuObjArray[0][i].style.opacity = 1;
			}
            
            
        } else
        {
            menuObjArray[7][i].className = divovername + "Close";
            menuObjArray[4][i] = 0;
            menuObjArray[0][i].style.height = 0 + "px";
            menuObjArray[6][i] = false;
            if(doFading)
			{
				if (menuObjArray[0][i].filters)
					menuObjArray[0][i].filters.alpha.opacity = 0;
				else
					menuObjArray[0][i].style.opacity = .0;
			}
        }

    }//end if

    mainMenuDiv = null;
    subMenuDiv =  null;
    menuContainerDiv= null;
    itemContainerDiv= null;
    
}

function SetSlide()
{   
    if (isLocked)
        return;
    else
        isLocked = this.parentNode;    
    
    for (var i=0 ;i < menuObjArray[0].length; i++)
    {
        if(menuObjArray[6][i] && (menuObjArray[3][i] != this.parentNode) && autoClose )
          CloseMenu(i);
    }
    
    for (var i=0 ;i < menuObjArray[0].length; i++)
    {
        if (menuObjArray[3][i] == this.parentNode)
        {
            if (menuObjArray[5][i] == null)
                menuObjArray[5][i] = setInterval("RunSlide(" + i + ")", slideDelay);
            break;
        }
    }
    
    

}






function CloseAllMenus()
{
    for (var i=0 ;i < menuObjArray[0].length; i++)
    {
          if (menuObjArray[6][i] )
             CloseMenu(i);
    }
}

function CloseMenu(objIndex)
{
  if(doFading)
  {
    if(menuObjArray[0][objIndex].filters)
	menuObjArray[0][objIndex].filters.alpha.opacity = 0;
    else
	menuObjArray[0][objIndex].style.opacity = 0;
  }
  
  switch(GetState(menuObjArray[7][objIndex].className))
  {
    case 0:
        menuObjArray[7][objIndex].className = divovername + "Close" ;
        break;
    case 1:
       menuObjArray[7][objIndex].className = divovername + "CloseOver" ;
       break;
    case 2:
        menuObjArray[7][objIndex].className = divovername + "CloseOver" ;
        break;
    case 3:
    
    
  }

  menuObjArray[1][objIndex].style.display = 'none';
  menuObjArray[4][objIndex] = 0;
  menuObjArray[0][objIndex].style.height = 0 + "px";
  clearInterval(menuObjArray[5][objIndex]);
  menuObjArray[5][objIndex] = null;
  menuObjArray[6][objIndex] = false;
  isLocked = null;
  return 0;

}

function GetState(cstate)
{

    if(divovername  == cstate )
      return 0;
    if((divovername + "Over" ) == cstate )
      return 1;
    if((divovername + "Close" ) == cstate )
      return 2;
    if( (divovername + "CloseOver")  == cstate )
      return 3;
  
  return 10;
}

function RunSlide(objIndex)  
{

    if (menuObjArray[6][objIndex])
    {
      if(doFading)
	{
            if(menuObjArray[0][objIndex].filters)
		menuObjArray[0][objIndex].filters.alpha.opacity -= 100/ ( ( (menuObjArray[2][objIndex] * divHeight) / moveSlidePix) +1);
            else
		menuObjArray[0][objIndex].style.opacity -= .9/(((menuObjArray[2][objIndex] * divHeight) / moveSlidePix)+1);
        }
        
        menuObjArray[1][objIndex].style.display = 'none';
        menuObjArray[4][objIndex] -=  moveSlidePix;
        if (menuObjArray[4][objIndex] > 0)
            menuObjArray[0][objIndex].style.height = menuObjArray[4][objIndex] + "px";
        else
        {
           CloseMenu(objIndex);
        }
        
        return 0;
        
    }

    if (!menuObjArray[6][objIndex])
    {
		if(doFading)
		{
			if(menuObjArray[0][objIndex].filters)
				menuObjArray[0][objIndex].filters.alpha.opacity += 100/ ( ( (menuObjArray[2][objIndex] * divHeight) / moveSlidePix) +1);
			else
			{
				opcVal = parseFloat(menuObjArray[0][objIndex].style.opacity);
				opcVal += .9/((menuObjArray[2][objIndex] * divHeight) / moveSlidePix);
				menuObjArray[0][objIndex].style.opacity = opcVal;
			}
		}
        menuObjArray[4][objIndex] +=  moveSlidePix;
        if (menuObjArray[4][objIndex] < (menuObjArray[2][objIndex] * divHeight))
            menuObjArray[0][objIndex].style.height = menuObjArray[4][objIndex] + "px";
        else
        {
			
			
			if(doFading)
			{
				if(menuObjArray[0][objIndex].filters)
					menuObjArray[0][objIndex].filters.alpha.opacity = 100;
				else
					menuObjArray[0][objIndex].style.opacity = 1;
			}
	
            menuObjArray[4][objIndex] = (menuObjArray[2][objIndex] * divHeight);
            menuObjArray[0][objIndex].style.height = (menuObjArray[2][objIndex] * divHeight)+ "px";			     
            menuObjArray[1][objIndex].style.display = 'inline';
            clearInterval(menuObjArray[5][objIndex]);
            menuObjArray[5][objIndex] = null;
            menuObjArray[6][objIndex] = true;
            
            
 
              
             switch(GetState(menuObjArray[7][objIndex].className))
              {
                case 0:
                   // menuObjArray[7][objIndex].className = divovername + "Close" ;
                    break;
                case 1:
               //    menuObjArray[7][objIndex].className = divovername + "CloseOver" ;
                  break;
                case 2:
                   menuObjArray[7][objIndex].className = divovername;
                    break;
                case 3:
                    menuObjArray[7][objIndex].className = divovername + "Over" ;
                
              }

           
			

            isLocked = null;
            return 0;
        }       
        return 0;
        
    }


}

function ChangeStyle()
{
    className = String(this.className);

    if (className.substring(className.length - 4, className.length) == "Over")
        this.className = className.substring(0,className.length - 4);
    else
        this.className = this.className + "Over";
      

}
