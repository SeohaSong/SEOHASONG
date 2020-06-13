import time
import asyncio


N = 1000
SIZE = 10000

def run_sub(i, mode):
    if mode == "w":
        with open("tests/test%s" % i, "wb") as f:
            data = b'\x00'*SIZE
            f.write(data)
    elif mode == "r":
        with open("tests/test%s" % i, "rb") as f:
            data = f.read()
    return len(data)

async def run_main(mode):
    futures = [loop.run_in_executor(None, run_sub, i, mode) for i in range(N)]
    start = time.time()
    results = [f.result() for f in (await asyncio.wait(futures))[0]]
    print(time.time()-start)
    print(set(results))

def run_main_(mode):
    start = time.time()
    results = [run_sub(i, mode) for i in range(N)]
    print(time.time()-start)
    print(set(results))


if __name__ == "__main__":

    mode = 'w'
    print("=====%s=====" % mode)
    loop = asyncio.get_event_loop()
    loop.run_until_complete(run_main(mode))
    loop.close()
    run_main_(mode)

    asyncio.set_event_loop(asyncio.new_event_loop())
  
    mode = 'r'
    print("=====%s=====" % mode)
    loop = asyncio.get_event_loop()
    loop.run_until_complete(run_main(mode))
    loop.close()
    run_main_(mode)
