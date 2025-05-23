# -*- coding: utf-8 -*-
"""
-------------------------------------------------
   File Name：     testRedisClient
   Description :
   Author :        JHao
   date：          2020/6/23
-------------------------------------------------
   Change Activity:
                   2020/6/23:
-------------------------------------------------
"""
__author__ = 'JHao'

from setting import DB_CONN

def testRedisClient():
    from db.dbClient import DbClient
    from helper.proxy import Proxy

    # 使用配置文件中的连接信息
    uri = DB_CONN
    db = DbClient(uri)
    db.changeTable("use_proxy")
    proxy = Proxy.createFromJson('{"proxy": "118.190.79.36:8090", "https": false, "fail_count": 0, "region": "", "anonymous": "", "source": "freeProxy14", "check_count": 4, "last_status": true, "last_time": "2021-05-26 10:58:04"}')

    print("put: ", db.put(proxy))

    print("get: ", db.get(https=None))
    print("exists: ", db.exists("27.38.96.101:9797"))
    print("exists: ", db.exists("27.38.96.101:8888"))
    print("pop: ", db.pop(https=None))
    print("getAll: ", db.getAll(https=None))
    print("getCount", db.getCount())


if __name__ == '__main__':
    testRedisClient()

