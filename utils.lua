function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
    else
        return false
    end
end

function get_date_from_unix(unix_time)
    local day_count, year, days, month = function(yr) return (yr % 4 == 0 and (yr % 100 ~= 0 or yr % 400 == 0)) and 366 or 365 end, 1970, math.ceil(unix_time/86400)
 
    while days >= day_count(year) do
        days = days - day_count(year) year = year + 1
    end
    local tab_overflow = function(seed, table) for i = 1, #table do if seed - table[i] <= 0 then return i, seed end seed = seed - table[i] end end
    month, days = tab_overflow(days, {31,(day_count(year) == 366 and 29 or 28),31,30,31,30,31,31,30,31,30,31})
    local hours, minutes, seconds = math.floor(unix_time / 3600 % 24), math.floor(unix_time / 60 % 60), math.floor(unix_time % 60)
    local period = hours > 12 and "pm" or "am"
    hours = hours > 12 and hours - 12 or hours == 0 and 12 or hours
    --return string.format("%d/%d/%04d %02d:%02d:%02d %s", days, month, year, hours, minutes, seconds, period)
    return string.format('%02d/%02d/%04d',days,month,year);
end

function dxDrawLinedRectangle( x, y, width, height, color, _width, postGUI )
    _width = _width or 1
    dxDrawLine ( x, y, x+width, y, color, _width, postGUI ) -- Top
    dxDrawLine ( x, y, x, y+height, color, _width, postGUI ) -- Left
    dxDrawLine ( x, y+height, x+width, y+height, color, _width, postGUI ) -- Bottom
    return dxDrawLine ( x+width, y, x+width, y+height, color, _width, postGUI ) -- Right
end