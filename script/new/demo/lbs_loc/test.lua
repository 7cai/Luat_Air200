module(...,package.seeall)
require"lbsloc"

--[[
使用基站获取经纬度的功能，必须按照以下步骤操作：
1、打开Luat物联云平台前端页面：https://iot.openluat.com/
2、注册用户
3、注册用户之后，创建一个新项目
4、创建新项目之后，进入项目
5、进入项目后，点击左边的项目信息，右边会出现信息内容，找到ProductKey：把ProductKey的内容，赋值给本文件中的ProductKey变量
]]

--用户必须根据自己的项目信息，修改这个变量的值
local ProductKey = "v32xEAKsGTIEQxtqgwCldp5aPlcnPs3K"

--是否查询GPS位置字符串信息
local qrylocation

--[[
函数名：print
功能  ：打印接口，此文件中的所有打印都会加上test前缀
参数  ：无
返回值：无
]]
local function print(...)
	_G.print("test",...)
end

--[[
函数名：qrygps
功能  ：查询GPS位置请求
参数  ：无
返回值：无
]]
local function qrygps()
	qrylocation = not qrylocation
	lbsloc.request(getgps,qrylocation)
end

--[[
函数名：getgps
功能  ：获取经纬度后的回调函数
参数  ：
		result：number类型，获取结果，0表示成功，其余表示失败。此结果为0时下面的3个参数才有意义
		lat：string类型，纬度，整数部分3位，例如031.2425864
		lng：string类型，经度，整数部分3位，例如121.4736522
		location：string类型，GB2312编码的位置字符串。调用lbsloc.request查询经纬度，传入的第二个参数为true时，才返回本参数
返回值：无
]]
function getgps(result,lat,lng,location)
	print("getgps",result,lat,lng,location)
	--获取经纬度成功
	if result==0 then
	--失败
	else
	end
	sys.timer_start(qrygps,20000)
end

--配置产品密钥
lbsloc.setup(ProductKey)
--20秒后去查询经纬度，查询结果通过回调函数getgps返回
sys.timer_start(qrygps,20000)
