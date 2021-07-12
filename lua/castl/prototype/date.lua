--[[
    Copyright (c) 2014, Paul Bernier
    
    CASTL is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    CASTL is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.
    You should have received a copy of the GNU Lesser General Public License
    along with CASTL. If not, see <http://www.gnu.org/licenses/>.
--]]

-- [[ CASTL Date prototype submodule]] --
-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/prototype
local ldate=require'date-j'

return function(datePrototype)
    local date, time, difftime = os.date, os.time, os.difftime
    local format = string.format

    _ENV = nil

    datePrototype.toString = function (this)
        return date('%a %h %d %Y %H:%M:%S GMT%z (%Z)', this._timestamp / 1000)
    end

    datePrototype.getDate = function (this) return ldate(this._timestamp / 1000):getday() end
    datePrototype.getDay = function (this) return ldate(this._timestamp / 1000):getweekday() - 1 end
    datePrototype.getFullYear = function (this) return ldate(this._timestamp / 1000):getyear() end
    datePrototype.getHours = function (this) return ldate(this._timestamp / 1000):gethours() end
    datePrototype.getMilliseconds = function (this) return this._timestamp % 1000 end
    datePrototype.getMinutes = function (this) return ldate(this._timestamp / 1000):getminutes() end
    datePrototype.getMonth = function (this) return ldate(this._timestamp / 1000):getmonth() - 1 end
    datePrototype.getSeconds = function (this) return ldate(this._timestamp / 1000):getseconds() end

    datePrototype.getTime = function(this)
        return this._timestamp
    end

    datePrototype.getTimezoneOffset = function(this)
        local now = time()
        return difftime(now, time(date("!*t", now))) / 60
    end

    datePrototype.getUTCDate = function (this) return ldate(this._timestamp / 1000):toutc():getday() end
    datePrototype.getUTCDay = function (this) return ldate( this._timestamp / 1000):toutc():getweekday() - 1 end
    datePrototype.getUTCFullYear = function (this) return ldate( this._timestamp / 1000):toutc():getyear() end
    datePrototype.getUTCHours = function (this) return ldate( this._timestamp / 1000):toutc():gethours() end
    datePrototype.getUTCMilliseconds = datePrototype.getMilliseconds
    datePrototype.getUTCMinutes = function (this) return ldate( this._timestamp / 1000):toutc():getminutes() end
    datePrototype.getUTCMonth = function (this) return ldate( this._timestamp / 1000):toutc():getmonth() - 1 end
    datePrototype.getUTCSeconds = function (this) return ldate( this._timestamp / 1000):toutc():getseconds() end

    local setDateTimeX = function(this, key, value,isUtc)
        local millis = this._timestamp % 1000
        local ld = ldate(this._timestamp / 1000)
        if isUtc then 
            ld=ld:toutc()
        end
        local y,mo,d=ld:getdate();
        local h,mi,s=ld:gettime();
        local o={
            year=y,
            month=mo,
            day=d,
            hour=h,
            minute=mi,
            second=s
        }
        o[key] = value
        this._timestamp = ldate(o):elapsed_ms()+ millis
    end
    local setDateTime = function (this, key, value) return setDateTimeX(this, key, value) end
    local setDateTimeUTC = function(this, key, value)
        return setDateTimeX(this, key, value,true)
    end

    datePrototype.setDate = function (this, dayValue) setDateTime(this, "day", dayValue) end
    datePrototype.setFullYear = function (this, yearValue) setDateTime(this, "year", yearValue) end
    datePrototype.setHours = function (this, hoursValue) setDateTime(this, "hour", hoursValue) end
    datePrototype.setMinutes = function (this, minutesValue) setDateTime(this, "min", minutesValue) end
    datePrototype.setMonth = function (this, monthValue) setDateTime(this, "month", monthValue + 1) end
    datePrototype.setSeconds = function (this, secondsValue) setDateTime(this, "sec", secondsValue) end

    datePrototype.setMilliseconds = function (this, millisValue)
        local d = ldate(this._timestamp / 1000):elapsed_ms()
        this._timestamp = d - (d%1000)  + millisValue
    end

    datePrototype.setTime = function (this, timeValue)
        this._timestamp = timeValue
    end

    datePrototype.setUTCDate = function (this, dayValue) setDateTimeUTC(this, "day", dayValue) end
    datePrototype.setUTCFullYear = function (this, yearValue) setDateTimeUTC(this, "year", yearValue) end
    datePrototype.setUTCHours = function (this, hoursValue) setDateTimeUTC(this, "hour", hoursValue) end
    datePrototype.setUTCMinutes = function (this, minutesValue) setDateTimeUTC(this, "min", minutesValue) end
    datePrototype.setUTCMonth = function (this, monthValue) setDateTimeUTC(this, "month", monthValue + 1) end
    datePrototype.setUTCSeconds = function (this, secondsValue) setDateTimeUTC(this, "sec", secondsValue) end

    datePrototype.setUTCMilliseconds = function (this, millisValue)
        local d = ldate(this._timestamp / 1000):toutc():elapsed_ms()
        this._timestamp = (time(d) * 1000) + millisValue
    end

    datePrototype.toDateString = function(this)
        return ldate(this._timestamp / 1000):fmt('%a %h %d %Y')
    end

    datePrototype.toISOString = function(this)
        return ldate(this._timestamp / 1000):fmt('%Y-%m-%dT%H:%M:%S.') .. format('%03dZ', this._timestamp % 1000)
    end

    datePrototype.toJSON = datePrototype.toISOString
    datePrototype.toLocaleDateString = datePrototype.toDateString
    datePrototype.toLocaleString = datePrototype.toString

    datePrototype.toTimeString = function(this)
        return ldate(this._timestamp / 1000):fmt('%H:%M:%S GMT%z (%Z)')
    end
    
    datePrototype.toLocaleTimeString = function(this)
        return ldate( this._timestamp / 1000):fmt('%H:%M:%S')
    end

    datePrototype.toUTCString = function(this)
        return ldate(this._timestamp / 1000):toutc():fmt('%a %h %d %Y %H:%M:%S GMT')
    end

    datePrototype.valueOf = function(this)
        return this._timestamp
    end

end
