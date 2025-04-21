# 代理池 API 接口文档

基础URL: http://127.0.0.1:5010

## 接口列表

### 1. 获取单个代理
- 接口: `/get/`
- 方法: GET
- 参数: 
  - type: [可选] 指定代理类型，值为 "https" 时仅返回支持https的代理
- 返回示例:
```json
{
    "proxy": "1.2.3.4:8080",
    "https": true,
    "anonymous": "",
    "check_count": 1,
    "fail_count": 0,
    "last_status": true,
    "last_time": "2025-04-21 09:34:17",
    "region": "CN",
    "source": "freeProxy01"
}
```

### 2. 获取并删除代理
- 接口: `/pop/`
- 方法: GET
- 参数:
  - type: [可选] 指定代理类型，值为 "https" 时仅返回支持https的代理
- 返回格式同 `/get/`
- 说明: 获取代理后会立即从代理池删除该代理

### 3. 获取所有代理
- 接口: `/all/`
- 方法: GET
- 参数:
  - type: [可选] 指定代理类型，值为 "https" 时仅返回支持https的代理
- 返回示例:
```json
[
    {
        "proxy": "1.2.3.4:8080",
        "https": true,
        ...
    },
    {
        "proxy": "5.6.7.8:3128",
        "https": false,
        ...
    }
]
```

### 4. 删除指定代理
- 接口: `/delete/`
- 方法: GET
- 参数:
  - proxy: [必填] 要删除的代理，格式为 "host:port"
- 返回示例:
```json
{
    "code": 0,
    "src": "success"
}
```

### 5. 获取代理池统计
- 接口: `/count/`
- 方法: GET
- 参数: 无
- 返回示例:
```json
{
    "count": 150,
    "http_type": {
        "http": 50,
        "https": 100
    },
    "source": {
        "freeProxy01": 20,
        "freeProxy02": 30,
        ...
    }
}
```

## 使用示例

### Python示例
```python
import requests

def get_proxy():
    """获取一个代理"""
    return requests.get("http://127.0.0.1:5010/get/").json()

def delete_proxy(proxy):
    """删除代理"""
    requests.get(f"http://127.0.0.1:5010/delete/?proxy={proxy}")

def get_https_proxy():
    """获取https代理"""
    return requests.get("http://127.0.0.1:5010/get/?type=https").json()

def get_all_proxies():
    """获取所有代理"""
    return requests.get("http://127.0.0.1:5010/all/").json()
```

### curl示例
```bash
# 获取代理
curl http://127.0.0.1:5010/get/

# 获取https代理
curl "http://127.0.0.1:5010/get/?type=https"

# 删除代理
curl "http://127.0.0.1:5010/delete/?proxy=1.2.3.4:8080"

# 获取所有代理
curl http://127.0.0.1:5010/all/

# 获取代理池统计
curl http://127.0.0.1:5010/count/
```

## 注意事项

1. 代理质量
   - 建议在使用代理时增加超时设置
   - 对代理进行失败重试机制
   - 代理失败时及时调用删除接口

2. 性能建议
   - 可以批量获取代理并本地缓存
   - 避免频繁调用API
   - 建议使用 `/all/` 接口获取代理后自行管理

3. 安全建议
   - 建议修改默认端口
   - 如果部署在公网，建议添加访问控制
   - 建议限制API访问频率