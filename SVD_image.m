clear;

img=imread('alphabet.jpg');          %圖檔名稱
img_r=double(img(:,:,1));      %圖片紅色數值
img_g=double(img(:,:,2));      %圖片綠色數值
img_b=double(img(:,:,3));      %圖片藍色數值

figure();                      %顯示視窗
imshow(uint8(img))

[m,n,o]=size(img);
[Ur,Sr,Vr]=svd(img_r);          %紅色數值矩陣的SVD分解
[Ug,Sg,Vg]=svd(img_g);          %綠色數值矩陣的SVD分解
[Ub,Sb,Vb]=svd(img_b);          %藍色數值矩陣的SVD分解
s=[];
fprintf('rank=%3.0f\n',rank(img_r));

maxR = round(((-m-n)+(m^2+n^2+6*m*n)^0.5)/2,0)-1; %maxR為可壓縮時的最大值(由公式得出)

for k=1:10
    %r的大小為(1/2)^k*maxR
    i = round((0.5^k)*maxR,0);
    rr=i;                                        
    rg=i;
    rb=i;
    s(rr)=Sr(rr,rr);            %Sr矩陣的size
    s(rg)=Sg(rg,rg);            %Sg矩陣的size
    s(rb)=Sb(rb,rb);            %Sb矩陣的size
    comp_r=Ur(:,1:rr)*Sr(1:rr,1:rr)*Vr(:,1:rr)';       
    comp_g=Ug(:,1:rg)*Sg(1:rg,1:rg)*Vg(:,1:rg)';        
    comp_b=Ub(:,1:rb)*Sb(1:rb,1:rb)*Vb(:,1:rb)';
    fprintf('rr=%3.f,rg=%3.f,rb=%3.f\n',rr,rg,rb);
    c(:,:,1) = comp_r;
    c(:,:,2) = comp_g;
    c(:,:,3) = comp_b;

    figure();
    imshow(uint8(c));

end
