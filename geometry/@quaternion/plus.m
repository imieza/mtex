function q = plus(q1,q2)
% pointwise addition

q = quaternion(q1.a + q2.a ,q1.b + q2.b,q1.c+q2.c,q1.d+q2.d);
