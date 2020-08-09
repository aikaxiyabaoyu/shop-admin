import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import redis.clients.jedis.Jedis;

public class StringTest {

    Jedis jedis;
    @Before
    public void before(){

        //创建连接
        jedis = new Jedis("192.168.17.178",6378);

    }

    @After
    public void after(){

        jedis.close();

    }

    @Test
    public void test1(){

        jedis.set("userName","admin");

        String userName = jedis.get("userName");

        System.out.print(userName);

    }
}
