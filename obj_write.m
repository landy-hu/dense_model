function obj_write(filename,vertices,faces)

% faces=faces;
fid=fopen(filename,'w');%remove the old imformation, write the new information
[x,y]=size(vertices);
for i=1:x
   fprintf(fid,'v ');
   for j=1:y-1
       fprintf(fid,'%f ',vertices(i,j));
   end
   fprintf(fid,'%f\r\n',vertices(i,y));%
end
fprintf(fid,'\n');%
[x,y]=size(faces);
for i=1:x
  fprintf(fid,'f ');
  for j=1:y-1
     fprintf(fid,'%d ',faces(i,j));
  end
  fprintf(fid,'%d\r\n',faces(i,y));%
end
fclose(fid);
end