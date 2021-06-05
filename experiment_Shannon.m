% 香农编码

Pd = input("输入离散信源概率分布：");

index = 1:length(Pd);

for i = 1:length(Pd)
   maximun = i;
   for j = i+1:length(Pd)
      if Pd(maximun) < Pd(j)
         maximun = j;
      end
   end
   tmp = Pd(i);
   Pd(i) = Pd(maximun);
   Pd(maximun) = tmp;
   
   tmp = index(i);
   index(i) = index(maximun);
   index(maximun) = tmp;
end

disp([index; Pd]);

p = 0.;
len = 0;

for j = 1:length(Pd)
   x = Pd(j);
   i = index(j);
   l = ceil(-log2(x));
   t = binF(p, l);
   
   fprintf("信源符号：%d，符号概率：%.3f，累加概率：%.3f，码长：%d，码字：%s\n", ...
      i, x, p, l, t);
   p = p + x;
   len = len + x * l;
end

H = sum(-Pd .* log2(Pd));
eta = H / len;
fprintf("\n信源信息熵：%.3f，平均码长：%.3f，编码效率：%.4f\n\n", H, len, eta);

function s = binF(number, digits)
   s = ""; number = number - floor(number);
   
   while strlength(s) < digits
      number = number * 2;
      if number < 0
         s = s + "0";
      else
         s = s + "1";
         number = number - 1;
      end
   end
end
