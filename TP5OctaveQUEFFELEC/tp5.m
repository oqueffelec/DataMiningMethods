
clear all
close all
clc

%% trace des lignes de niveau de J
n = 100;
[X, Y] = meshgrid(linspace(-1.25, 2.5, n), linspace(-1.75, 2, n));
ptx = reshape(X, n*n,1);
pty = reshape(Y, n*n,1);
pt = [ptx pty];

% Define the function J = f(\theta)
Jmat = (1-pt(:,1)).^2 + 100*(pt(:, 2) - pt(:, 1).^2).^2;
%exp(-0.1)*(exp(pt*a) + exp(pt*b) + exp(pt*c));

% Create the surface plot using contour command
figure(1);
contour(X, Y, reshape(Jmat, n, n), [40:-5:0 1 0], 'linewidth', 1.5);
colorbar
axis tight
set(gca, 'fontsize', 18)


% A Completer ...

% � d�comenter si vous utilisez un pas fixe a chaque iteration
pas = 0.001;

% solution initiale
theta0 = [-1; 0];

% trace de theta0
figure(1), hold on
h = plot(theta0(1,:), theta0(2,:), 'ro');
set(h, 'MarkerSize', 8, 'markerfacecolor', 'r');
text(theta0(1,1), theta0(2,1)-0.175, '\theta_0', 'fontsize', 16)

theta=theta0;
eps=0.01;

% algo backtracking 
c=0.001;
ro=0.5;
k=1;
while norm(mongradient(theta))>eps
    
    % calcul de J
    J(k)=moncritere(theta);
    grad=mongradient(theta);
   
    % calcul de la direction de descente 
    direction = -grad;
    
    
    % Determination du pas de recherche
%      UNCOMMENT pour utiliser un pas fixe alpha = 0.001;
    %init alpha
    if k ==1
        alpha =1/norm(direction);
    else
        alpha=2*(J(k)-J(k-1))/dot(grad,direction);
    end
    fnew=moncritere(theta+alpha*direction);

    % backtracking 

    while fnew>J(k)+c*alpha*dot(grad,direction)
        alpha=ro*alpha;
        fnew=moncritere(theta+alpha*direction);
    end

    
    % mise a jour de theta = theta + alpha * direction
    theta = theta + alpha*direction;
    
    %calcul nouveau cout et grad
    J(k+1)=moncritere(theta+alpha*direction);
    grad=mongradient(theta+alpha*direction);
    % trace du theta courant
    plot(theta(1,:), theta(2,:), 'ro');
    if norm(mongradient(theta))<eps
        text(theta(1,1), theta(2,1)-0.175, '\theta_F', 'fontsize', 16);
    end
    
    k=k+1;

end
hold off

% trace du critere en fonction des iterations

