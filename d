作业，提交到gitee上。 完成以后，把gitee地址发我
另外，可以查任何资料，但务必搞清楚。

1. 使用seata完成分布式事务：还是以 product 和 order 为例。
2. synchronized和ReentrantLock和区别，针对于每一个区别，写出一个例子演示。
   ReentrantLock可以有针对性的唤醒锁 synchronized不行
   ReentrantLock可以在线程等待时强制终止 synchronized不行
   ReentrantLock可以手动上锁释放锁   synchronized是JVM级别不可以手动添加释放
   ReentrantLock支持公平锁  synchronized只能是非公平锁
   ReentrantLock 可以利用读锁制作缓存  synchronized 只能是写锁
3. volidate关键字保证可见性的例子演示，包括正例、反例。
class App {

    volatile int i= 0;

    void set() {
 synchronized(this){
    this.wait();
}
   i=Math.random(100);
   notify();
      
    }
   int get(){
    synchronized(this){
     this.wait();
 }
  notify();
   return i;

}
  class p implments runable{
   App a;
   public p(App a){
    this.a=a;
  }
  public void run(){
     a.set();
    a.get();
   }
 }
public class text{
   public static void main(String[]args){
       APP a=new APP();
      Thread b=new Thread(a);
      Thread b1=new Thread(a)
      b.start();
      b1.start();
   }
}

4. 悲观锁和乐观锁的区别？
悲观锁每次都假设最坏的情况 每次拿数据时都认为别人会修改，所以每次拿数据都会上锁，这样别人就会一直阻塞直到拿到锁 
乐观锁是每次都做最好的打算，每次拿数据都不会上锁，但是每次更新都会判断是否有人修改过数据

5. 什么是脏读？不可重复读？ 幻读？ 以及如何解决这些问题。
脏读：就是在不可重复读隔离级别下，在同一事务里读到不同的数据    解决办法，提高事务隔离级别到读已提交
不可重复读：就是在读已提交隔离级别下，在提交完事务之后发现读到的事务和之前不一致   解决办法，提高事务隔离级别到可重复读
幻读：就是在可重复读隔离级别下，自己读到的数据与外界数据不一致， 解决办法，提高事务隔离级别到串行化级别

6. 什么是间隙锁？
间隙锁是在可重复读事务隔离级别下，在索引的间隙加上锁

7. MVCC是什么，请描述清楚。
MVCC 多版本并发控制  是管理数据库中对数据库的并发访问   在每一次更新数据库时都会更新底层的readview（readview记录的是活跃中的事务），在读已提交事务隔离级别下，每次更新数据库都会生成一个版本号并且记录在read
view中 ，在用户需要读时将会根据版本号从上往下对照，直到读取到非活跃的最新的版本   在可重复读事务隔离级别下，在第一次访问数据库时回更新一次readview，会生成readview的快照，导致之后每次读取的数据都是
第一次访问时的版本

8. docker容器和虚拟机的区别是什么？
虚拟机是分钟级  而docker是秒级
docker需要的资源更少 隔离性更弱 安全性弱

9. 多生产者多消费者，换个场景例子写一遍，不要使用我的碗架例子了。
class functory{
  private int i=0;
 public void getA(){
    synchronized(this){
      while(i%2!=0){
          this.wait();
       }
         System.out.println("A");
          i++;
         notify();
    }
 }
 public void getB(){
    synchronized(this){
           while(i%2==0){
             this.wait();
          }
        System.out.println("B");
           i++;
           notify();
        }
  }
  class A implements runnable{

    private functory f;
   public A(functory f){
        this.f=f;
   }
   public void run(){
     for (int i=0;i<100;i++){
           f.getA();
      }
   }
 }
   class B implements runnable{

    private functory f;
   public B(functory f){
        this.f=f;
   }
   public void run(){
     for (int i=0;i<100;i++){
           f.getB();
      }
   }
 }
  public static void main(String[]args){
   functory f=new functory();
   A a=new A(f);
   B b=new B(f);
   Thread a=new Thread(a);
   Thread b=new Thread(b);
   a.start();
   b.start();
}

}

10. 线程安全的集合有哪些？ 
vector  hashitable

11. 什么是CAS？
cas是一种基于锁的操作，而且是乐观锁  CAS机制中使用了3个基本操作数：内存地址V，旧的预期值A，要修改的新值B
更新一个变量的时候，只有当变量的预期值A和内存地址V当中的实际值相同时，才会将内存地址V对应的值修改为B。

12. Jdk1.7 Jdk1.8中的Map有什么区别？
jdk1.7 底层是数组加链表 使用的是头插法 扩容时会颠倒链表顺序
jdk1.8 底层是数组加链表加红黑树 使用的是尾插法 不会颠倒链表顺序

13. redis的逐出策略是什么？
redis每次在执行命令前会检查内存是否充足 如果不充足将会随机清理内存来保存新的命令

14. redis的淘汰策略是什么？
定时删除：当redis 的key过期立马删除
惰性删除：当redis的key过期不会立马删除  而是等到用户第二次访问时删除
定期删除：每隔一段时间 删除一部分的key

15. 如何能筛选出redis中的高热键？
  在客户端采用aop进行统计

16. 消息中间件的作用是什么？
  消息中间件可利用高效可靠的消息传递机制进行平台无关的数据交流，并基于数据通信来进行分布式系统的集成。通过提供消息传递和消息排队模型，可以在分布式环境下扩展进程间的通信
  解耦  消峰 扩展性 有序性  缓冲 异步通信

17. 如何保证RabbitMQ消息的可靠性？
  在每个消息中添加全局标识
   保证每个队列只有一个消费者且消息 过期时间 优先级一样

18. redis事务的作用是什么？ 通过redis如何实现乐观锁？
   redis事务就是保证多个命令之间的原子性
   乐观锁是使用watch来监视所有key 当事务提交时如果key发生了变化 则整个事务提交失败

19. 遍历Map的方式有哪些，写出代码。
  1. for(String key:map.keySet()){
               String value = map.get(key).toString();     
       System.out.println("key:"+key+" vlaue:"+value);
        
   }
 2. Iterator<Entry<String, Object>> it = map.entrySet().iterator();
   
    while(it.hasNext()){
              
            Entry<String, Object> entry = it.next();
     
          System.out.println("key:"+entry.getKey()+"  key:"+entry.getValue());
        
  }
  3.   for (Map.Entry<String, Object> m : map.entrySet()) {
        System.out.println("key:" + m.getKey() + " value:" + m.getValue());
    }


20. CountDownLatch和CyclicBarrier的区别是什么?
CountDownLatch是通过一个计数器来实现的，计数器的初始值为线程的数量
每当一个线程完成了自己的任务后，计数器的值就会减1。当计数器值到达0时，它表示所有的线程已经完成了任务，然后在闭锁上等待的线程就可以恢复执行任务
CyclicBarrier 主要是一个方法await  
await() 方法每被调用一次，计数便会减少1 当减到0时阻塞解除 并重新计数

21. TCP和UDP的区别是什么？
  TCP是面向链接的，UDP是无链接的  TCP传输的消息具有可靠性 通过TCP传输的数据不会丢失，且按顺序到达

22. TCP为什么需要3次握手，而不是2次，或者4次？
如果A与B建立链接  则分为三步  1 A给B发  B知道A能发   2 B给A发 A知道B能发 收  3 A给B发 B知道A能收
如果建立两次握手  则不能保证消息的可靠性
如果建立四次握手  则会造成浪费资源

23. HashSet的原理是什么？ 
先通过hash值找到它的位置 如果该位置没有元素则直接插入  如果该位置有元素 则调用equeals方法判断两元素是否为同一元素相同则不能添加

24. 雪花算法(Snow Flake)是什么？能解释一下原理吗？
雪花算法可以生成一个64位二进制数   41位时间戳  10位机器号 12位序列号 
根据机器与时间不同  在69年之内保证id不重复

25. 分布式id的解决方案有哪些？ 各有什么优缺点？
UUID  本地生成ID，不需要进行远程调用，时延低，性能高。 
    缺点 UUID过长，16字节128位，通常以36长度的字符串表示，很多场景不适用  完全随机无排序
 类snowflake  时间戳在高位，自增序列在低位，整个ID是趋势递增的，按照时间有序
              性能高，每秒可生成几百万ID
           缺点 依赖机器时钟，如果机器时钟回拨，会导致重复ID生成。  单机是递增 分布式环境不会递增的情况

26. 分布式id为什么不直接干脆使用UUID？ 而是使用雪花算法？
因为uuid完全随机而且有可能会重复，雪花算法可以在69年内保证id不重复

27. 索引的数据结构了解吗？ 
底层是b+树 数据都在叶子层 根节点数据有冗余

28. 聚集索引和非聚集索引的区别？
每个表只能有一个聚集索引聚集索引一般是有序的int型数据一般都用主键   可以有多个非聚集索引，使用非聚集索引需要回表，效率比聚集索引低

29. 索引中的“回表”是什么意思？
是无法直接查询列的数据，需要先通过非聚集索引查询到其聚集索引再查询到数据

30. 什么是索引中的最左原则？
在复合索引中，只有左边的列确定了 右边的列才有序

31. 什么是小表驱动大表原则？
就是在联合查询寻中，全表扫描小表，索引大表，这样可以大大提高查询效率

32. mysql中，如何为select语句添加共享锁 和 排他锁？
 共享索 加for update   排他锁 加lock in share mode

33. 共享锁和排他锁的区别是什么？
共享锁又称读锁  一个事物添加了共享锁 其他事务不能修改只能访问
排他锁又称写锁  一个事务添加了排他锁 则只能该事务读写，其他事务则不能获取锁

34. SpringMVC的工作原理？ SpringMVC这样的工作原理有什么好处？
用户发送请求到前端控制器  前端控制器调用映射器并返回handler获得处理请求的控制器  前端控制器再调用适配器处理器处理请求并返回modelandview  
前端控制器再调用视图解析器并返回视图  前端控制器对视图进行渲染 并返回给页面
这样的工作原理使每个组件分工明确，根据不同的场景替换也方便

35. 代理模式、适配器模式、装饰器模式看起来很相似，它们的区别是什么？
代理模式是用户在访问对象时必须经过代理对象才可以访问到目标对象，特点是可以在代理对象中添加逻辑代码控制请求是否可以到达目标对象，则是请求是否能抵达目标对象是不确定的。
适配器模式是将两个不同接口的的对象“缝合”在一起，将本来无法匹配的接口更换为用户需要的接口
装饰器模式则是对目标对象的功能进行扩展，是继承的替代方案，比继承更灵活

36. Spring中，Bean的生命周期是什么？ 如果要为某个bean制作代理对象，再把代理对象放入容器中，应该在哪个环节进行？
bean实例化   bean属性注入   	使用beannameaware中的 setbeanname方法   使用 beanfactroyaware中的setbeanfactroy方法  调用applicationcontext 中的 setapplicationcontext方法
调用BeanPostProcessor 中的postProcessBeforeInitialization()方法  如果实现了 InitializingBean接口 调用afterPropertiesSet方法  
如果Bean 实现了BeanPostProcessor接口，Spring就将调用他们的postProcessAfterInitialization()方法  bean准备就绪程序可以使用  如果bean实现了DisposableBean接口，Spring将调用它的destory()接口方法

37. map 的深拷贝和浅拷贝的区别？
浅拷贝：复制的是引用对象，这两个只要有一个改变操作内存区域内容同时会改变。
深拷贝：也叫完全复制，是两个完全独立的内存 互不影响

38. final、finally、finalize的区别？
final 是用来修饰类 方法 变量的 用来防止修改类 方法 变量的
finally是在try/catch中一定会执行的语句
finalize是垃圾回收机制中的一个方法，一般new出来的对象都会自动回收不需要手动回收

39. 谈谈你对GC的认识。
GC垃圾回收机制 其中有一个finalize方法 new出来的对象一般都会自动回收特殊情况下需要手动实现方法例如socker链接

40. 如何实现mysql的主从复制？ 请描述一下原理和步骤。
  在主服务器上修改 配置文件
  修改完成mysql的配置后，要重启mysql服务使之生效
 授权一个账号，让从服务器通过该账号读取log-bin日志里面的内容
   赋予从库权限账号，允许用户在主库上读取日志，也就是Slave机器读取File权限
  查看最新的log-bin日志，记录主服务器里面的最新的二进制的名称和pos位置
  修改从服务器的数据库配置文件
  停止从服务器
  开始配置
  启动从服务器
  验证配置是否成功

41. 谈谈你对java中泛型的理解，以及什么是泛型的“擦除”?
泛型是在编译期间对代码类型规范的要求，泛型擦除则是在编译时泛型统一会被擦除掉   在反射中，运行时才能确定的类编译时泛型是不起作用的，统一为object

42. hibernate和mybatis的区别是什么？
hibernate和mybatis都是持久化层框架  hibernate不用自己手动写sql语句方便但不灵活
mybatis效率高  hibernate 效率低
hibernate无序关注底层，只需要管理好对象即可   mybatis需要管理底层映射关系

43. http请求中常见的响应码有哪些，分别是什么含义？
200 相应成功
404 相应页面未找到
500 服务器错误

44. 说说SpringMVC中的常用注解
pathvariable 
restcontroller
responsebody 
requestbody 
autowide
configiution
service
controller
requestparam
service
respositroy
component

45. 谈谈你对restful的认识
restful是一种架构风格 每个请求都有它的唯一标识符 对资源的操作不会更改标示符  无状态

46. 分布式锁用过吗？工作原理是什么？
   用过，先用setnx争抢锁，抢到锁之后再设置expire设置过期时间防止忘记释放锁

47. cookie和session的区别是什么？
session和cookie都是保存用户的访问信息的 session是保存在服务器的，相对安全，而cookie是保存在浏览器上的 不安全

48. ajax如何实现跨域访问呢？
  在配置类中添加 registry.addMapping("/**").allowedMethods("*").allowedOrigins("*");

49. 编程题：编写一个程序，检测一个字符串中的括号是否配对。
    如："(1)(2)"就是配对的  "((23)45)"也是配对的，"(1+1)*2)"不是配对的 "1+2)(3+4(22)"也不是配对的。
 class text2 {

     Boolean flag=false;
     int i=0;
     public Boolean  aBoolean(String string){
         for(int i=0;i<string.length();i++) {
             if(String.valueOf(string.charAt(i)).equals("(")){
                 i++;
             }else if(String.valueOf(string.charAt(i)).equals(")")){
                 i--;
             }
             while (i<0){
                 break;
             }

         }
         if(i==0){
             flag=true;
         }
     return flag;
     };

50. Jdk1.7的HashMap，在多线程访问下，会有什么问题？ 为什么？ 
会导致死锁 hashmap线程不安全  1.7的hashimap扩容使用的是头插法，会出现环状列表
