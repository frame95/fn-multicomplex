%base nucleo matrice mod 2 (come colonne di una matrice)
function X=ker(A)
X=[];
if isempty(A) %caso vuoto
X=eye(size(A,2));
return
end

aa=A;
[m_aa, n_aa] = size(aa);
temp_row = sparse(1,n_aa); %was zeros       

row_idx = 1;
column_idx = 1;
row_store = [];
column_store = [];

% Find the multiplicative inverse of the field elements.
% This will be used for setting major elements in the matrix to one.
%[field_inv ignored] = find( mod( [1:(p-1)].' * [1:(p-1)] , p ) == 1 );

% Search for major elements, trying to form 'identity' matrix.
while (row_idx <= m_aa) & (column_idx <= n_aa)

    % Look for a major element in the current column.
    while (aa(row_idx,column_idx) == 0) & (column_idx < n_aa)

        % In the current column, search below all the rows that already
        % have major elements.
        idx = find( aa(row_idx:m_aa, column_idx) == 1 );

        if isempty(idx)
            % There are no major elements in this column.
            % Move to the next column.
            column_idx = column_idx +1;
             
        else
            % There is a major element in this column.
            % See if any are already equal to one.            
         %(paolo)   idx = [ find(aa(row_idx:m_aa, column_idx) == 1); idx ];
            idx = idx(1);

            % Swap the current row with a row containing a major element.
            temp_row = aa(row_idx,:);
            aa(row_idx,:) = aa(row_idx+idx-1,:);
            aa(row_idx+idx-1,:) = temp_row;

        end
    end


    % Clear all non-zero elements in the column except the major element,
    % and set the major element to one.
    if ( ( aa(row_idx,column_idx) == 1 ) & ( column_idx <= n_aa ) )

        % The current element is a major element.
        row_idx %provvisorio
        row_store = [row_store row_idx];
        column_store = [column_store column_idx];

        % If the major element is not already one, set it to one.
        %if (aa(row_idx,column_idx) ~= 1)
         %  aa(row_idx,:) = mod( field_inv( aa(row_idx,column_idx) ) * aa(row_idx,:), p );
         %end;

        % Find the other elements in the column that must be cleared,
        idx = [ find( aa(:,column_idx) == 1 )' ];
        % and set those elements to zero.
        for i = idx
            if i ~= row_idx
                aa(i,:) = mod( aa(i,:) + aa(row_idx,:) *  aa(i,column_idx), 2 );
            end
        end

        column_idx = column_idx + 1;

    end

    row_idx = row_idx + 1;

end
%rango
L=length(row_store);
if L==0  %rango nullo
X=eye(size(A,2));
return
end
    
if column_store(1)>1 %se primo pivot non e' a estrema sinistra
X=eye(n_aa);
X=X(:,column_store(1)-1);
end
%altrimenti vuota

column_store(L+1)=n_aa+1;  %ad hoc per il ciclo sotto

for i=1:L %row_store
for j=column_store(i)+1:column_store(i+1)-1
V=zeros(n_aa,1);
V(j,1)=1; %pongo variabile libera = 1
CU=find(aa(:,j));%uni della colonna j
for k=CU' %righe di tali uni
E=find(aa(k,:)); %elementi non nulli riga k    
V(E(1),1)=1; %E(1) e' il pivot
end

X=[X,V];
    
    
end    
end
